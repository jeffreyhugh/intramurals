import * as React from 'react';
import { toast } from 'react-hot-toast';

import { useGroupchats } from '@/lib/hooks/useGroupchats';
import { requireAuth } from '@/lib/requireAuth';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';
import { ChatSidebar } from '@/components/chats/ChatSidebar';
import { ChatContent } from '@/components/chats/ChatContent';

export default function Page() {
  // const chats = useGroupchats();

  // if (chats.error) {
  //   toast.error('Error fetching chats, please check the console');
  //   //eslint-disable-next-line no-console
  //   console.error(chats.error);
  // }

  return (
    <Layout>
      <Seo templateTitle='Chat' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <div className='mt-2 h-full w-full'>
              <div className='flex h-full w-full'>
                <div className='h-full w-1/4 flex-grow-0'>
                  <ChatSidebar />
                </div>
                <div className='h-full w-3/4 flex-grow-0'>
                  <ChatContent />
                </div>
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
