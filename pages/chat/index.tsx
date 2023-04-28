import * as React from 'react';

import { requireAuth } from '@/lib/requireAuth';

import { ChatContent } from '@/components/chats/ChatContent';
import { ChatSidebar } from '@/components/chats/ChatSidebar';
import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  return (
    <Layout>
      <Seo templateTitle='Chat' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout h-c flex flex-col gap-2'>
            <div>
              <Breadcrumbs />
            </div>
            <div className='flex w-full'>
              <div className='w-48'>
                <ChatSidebar />
              </div>
              <div className='flex-grow'>
                <ChatContent />
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
