import { useSupabaseClient, useUser } from '@supabase/auth-helpers-react';
import { DateTime } from 'luxon';
import { useRouter } from 'next/router';
import { useEffect, useRef } from 'react';
import { useForm } from 'react-hook-form';
import { toast } from 'react-hot-toast';
import { useSWRConfig } from 'swr';

import clsxm from '@/lib/clsxm';
import { firstOrOnly } from '@/lib/firstOrOnly';
import { useGroupchatData } from '@/lib/hooks/useGroupchatData';
import { Database } from '@/lib/types/database.types';

type formValues = { content: string };

export const ChatContent = () => {
  const router = useRouter();
  const { id } = router.query;
  const chatID = firstOrOnly(id, '');

  const groupchatdata = useGroupchatData(chatID);

  const { handleSubmit, register, reset } = useForm<formValues>();

  const { mutate } = useSWRConfig();

  const client = useSupabaseClient<Database>();

  const scrollRef = useRef<HTMLDivElement>(null);
  useEffect(() => {
    if (scrollRef.current) {
      scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
    }
  }, [groupchatdata.data]);

  const user = useUser();
  if (!user) {
    return null;
  }
  const onSubmit = handleSubmit(async (data) => {
    const res = await client.from('groupchat_data').insert({
      content: data.content,
      from_user_id: user.id,
      to_group_id: chatID,
    });
    if (res.error) {
      // eslint-disable-next-line no-console
      console.error(res.error);
      toast.error('Error sending message, please check the console');
    } else {
      mutate(`groupchatData-${chatID}`);
      reset();
    }
  });

  if (chatID === '') {
    return <div>Choose a chat on the Sidebar to begin</div>;
  } else {
    if (groupchatdata.error) {
      return <div>Error fetching chat data, please check the console</div>;
    } else if (groupchatdata.isLoading || !groupchatdata.data) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className='h-c max-h-c flex w-full flex-col p-4'>
          <div
            className='flex flex-grow flex-col overflow-y-scroll'
            ref={scrollRef}
          >
            {groupchatdata.data.map((message, i) => (
              <div
                key={i}
                className={clsxm(
                  'chat',
                  message.user_id === user.id ? 'chat-end' : 'chat-start'
                )}
              >
                <div className='chat-header'>
                  {message.first_name}
                  <time className='ml-1 text-xs opacity-50'>
                    {DateTime.fromISO(message.message_time || '').toRelative()}
                  </time>
                </div>
                <div
                  className={clsxm(
                    'chat-bubble',
                    message.user_id === user.id ? 'chat-bubble-secondary' : ''
                  )}
                >
                  {message.content}
                </div>
              </div>
            ))}
          </div>
          <form className='mt-4 flex gap-4' onSubmit={onSubmit}>
            <input
              type='text'
              className='input-bordered input w-full'
              placeholder='Aa'
              {...register('content')}
            ></input>
            <button className='btn-primary btn' type='submit'>
              Send
            </button>
          </form>
        </div>
      );
    }
  }
};
