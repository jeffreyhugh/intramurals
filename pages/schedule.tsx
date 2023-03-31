import * as React from 'react';

import { requireAuth } from '@/lib/requireAuth';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  // TODO make hook for schedule

  return (
    <Layout>
      <Seo templateTitle='Schedule' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Schedule</h1>
            <div className='mt-6 w-full'></div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
