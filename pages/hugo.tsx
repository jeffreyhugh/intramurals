import * as React from 'react';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  return (
    <Layout>
      <Seo templateTitle='Hugo' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='text-3xl font-bold'>Hugo</h1>
          </div>
        </section>
      </main>
    </Layout>
  );
}
