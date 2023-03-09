import * as React from 'react';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Events() {
  return (
    <Layout>
      <Seo templateTitle='events' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='text-4xl font-bold'>events</h1>
          </div>
        </section>
      </main>
    </Layout>
  );
}
