import { useGroupchats } from '@/lib/hooks/useGroupchats';
import toast from 'react-hot-toast';
import { SomethingWentWrong } from '../SomethingWentWrong';
import Link from 'next/link';

export const ChatSidebar = () => {
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
          <Link key={groupchat.id} href={`/chat/${groupchat.id}`}>
            {groupchat.friendly_name}
          </Link>
        ))
      )}
    </div>
  );
};
