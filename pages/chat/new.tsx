import * as React from 'react';

import { NewGroupChat } from '@/components/chats/NewGroupChat';
import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  return (
    <Layout>
      <Seo templateTitle='New Groupchat' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <NewGroupChat />
          </div>
        </section>
      </main>
    </Layout>
  );
}
