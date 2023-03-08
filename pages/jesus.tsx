import * as React from 'react';

import { useLocation } from '@/lib/hooks/useLocation';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';

export default function Page() {
  const { data, isLoading, error } = useLocation(
    'c9d074e9-0f5e-4a2e-bc3c-8fb128264d5a'
  );

  if (error) {
    //eslint-disable-next-line no-console
    console.error(error);
  }

  // console.log(data);

  return (
    <Layout>
      <Seo templateTitle='Jesus' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='text-4xl font-bold'>Jesus</h1>

            {isLoading ? (
              <Skeleton className='h-8 w-full' />
            ) : !data ? (
              <>No data</>
            ) : (
              <div>Friendly name: {data.friendly_name}</div>
            )}
          </div>
        </section>
      </main>
    </Layout>
  );
}
