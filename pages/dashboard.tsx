import * as React from 'react';

import { requireAuth } from '@/lib/requireAuth';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  // TODO what data do we need here?

  return (
    <Layout>
      <Seo templateTitle='Dashboard' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Dashboard</h1>
            <div className='mt-6 w-full'>
              <>TODO what data do we need here?</>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
