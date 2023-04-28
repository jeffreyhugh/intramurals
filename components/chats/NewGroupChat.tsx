import { useSupabaseClient, useUser } from '@supabase/auth-helpers-react';
import { useRouter } from 'next/router';
import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { toast } from 'react-hot-toast';
import { TbX } from 'react-icons/tb';
import { v4 } from 'uuid';

import clsxm from '@/lib/clsxm';
import { useUsersForGroupchat } from '@/lib/hooks/useUsersForGroupchat';
import { Database } from '@/lib/types/database.types';

type NewGroupChatFormValues = {
  friendlyName: string;
  user: string;
};

export const NewGroupChat = () => {
  const client = useSupabaseClient<Database>();

  const router = useRouter();

  const {
    handleSubmit,
    register,
    resetField,
    formState: { errors },
  } = useForm<NewGroupChatFormValues>();

  const [userList, setUserList] = useState<
    Database['public']['Tables']['user_metadata']['Row'][]
  >([]);

  const users = useUsersForGroupchat();
  if (users.error) {
    //eslint-disable-next-line no-console
    console.error(users.error);
    toast.error('Could not load full user list, please check the console');
  }

  const me = useUser();
  if (!me) {
    return null;
  }

  const onSubmit = handleSubmit(async (data) => {
    const groupchatID = v4();
    const groupchatRes = await client.from('groupchats').insert({
      id: groupchatID,
      friendly_name: data.friendlyName,
    });

    if (groupchatRes.error) {
      //eslint-disable-next-line no-console
      console.error(groupchatRes.error);
      toast.error('Could not create groupchat, please check the console');
      return;
    }

    const membershipRes = await client.from('groupchat_memberships').insert(
      userList
        .map((user) => ({
          groupchat_id: groupchatID,
          user_id: user.id,
        }))
        .concat({ groupchat_id: groupchatID, user_id: me.id })
    );

    if (membershipRes.error) {
      //eslint-disable-next-line no-console
      console.error(membershipRes.error);
      toast.error('Could not add members, please check the console');
      return;
    }

    router.push(`/chat/${groupchatID}`);
  });

  return (
    <div className='flex w-full justify-center'>
      <form onSubmit={onSubmit} className='form-control w-96'>
        <label htmlFor='friendlyName' className='label'>
          <span className='label-text'>Name</span>
          <span className='label-text-alt'>Required</span>
        </label>
        <input
          type='text'
          placeholder='Name...'
          className={clsxm(
            'input-bordered input',
            errors.friendlyName && 'input-error'
          )}
          id='friendlyName'
          {...register('friendlyName', {
            required: 'You must enter a groupchat name',
          })}
        />

        <label htmlFor='userSelect' className='label mt-2'>
          <span className='label-text'>User Select</span>
        </label>
        <select
          id='userSelect'
          className='select-bordered select'
          {...register('user')}
          onChange={(e) => {
            const targetUser = (users.data || []).filter(
              (user) => user.id === e.target.value
            )[0];
            setUserList((i) => [targetUser, ...i]);
            resetField('user');
          }}
        >
          <option label='Choose...' className='hidden' />
          {(users.data || [])
            .filter(
              (user) => userList.indexOf(user) === -1 && user.id !== me.id
            )
            .map((user) => (
              <option
                key={user.id}
                label={`${user.first_name}${
                  user.last_name ? ` ${user.last_name}` : ''
                }`}
                value={user.id}
              />
            ))}
        </select>

        <label htmlFor='userList' className='label mt-2'>
          <span className='label-text'>User List</span>
        </label>
        <div className='h-48 overflow-hidden rounded-lg border border-base-300'>
          {userList.map((user) => (
            <div
              key={user.id}
              className='flex justify-between p-1 odd:bg-base-100 even:bg-base-200'
            >
              <span className='px-1'>{`${user.first_name}${
                user.last_name ? ` ${user.last_name}` : ''
              }`}</span>
              <button
                className='btn-outline btn-error btn-square btn-xs btn'
                title='Remove'
                onClick={() =>
                  setUserList((ul) => ul.filter((u) => u.id !== user.id))
                }
              >
                <TbX />
              </button>
            </div>
          ))}
        </div>

        <button className='btn-primary btn mt-6' type='submit'>
          Create
        </button>
      </form>
    </div>
  );
};
