import Link from 'next/link';
import { useRouter } from 'next/router';
import toast from 'react-hot-toast';

import clsxm from '@/lib/clsxm';
import { useGroupchats } from '@/lib/hooks/useGroupchats';

import { SomethingWentWrong } from '../SomethingWentWrong';

export const ChatSidebar = () => {
  const router = useRouter();
  const { id } = router.query;
  const chatID = id ? (Array.isArray(id) ? id[0] : id) : '';

  const groupchats = useGroupchats();
  if (groupchats.error) {
    toast.error('Error fetching chats, please check the console');
    //eslint-disable-next-line no-console
    console.error(groupchats.error);
  }

  return (
    <div className='flex h-full flex-col gap-2 bg-base-200 p-2'>
      {groupchats.error ? (
        <SomethingWentWrong />
      ) : groupchats.isLoading || !groupchats.data ? (
        <div>Loading...</div>
      ) : (
        groupchats.data.map((groupchat) => (
          <Link
            key={groupchat.id}
            href={`/chat/${groupchat.id}`}
            className={clsxm(
              'btn-ghost btn',
              groupchat.id === chatID && 'btn-active'
            )}
          >
            {groupchat.friendly_name}
          </Link>
        ))
      )}
    </div>
  );
};
