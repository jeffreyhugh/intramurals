import * as React from 'react';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Schedule() {
  return (
    <Layout>
      <Seo templateTitle='schedule' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='text-4xl font-bold'>Schedule</h1>
          </div>
        </section>
      </main>
    </Layout>
  );
}
