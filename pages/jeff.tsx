import * as React from 'react';

import { useLocations } from '@/lib/hooks/useLocations';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';

export default function Page() {
  // const data = { a: 3, b: 5 };
  // const { a, b } = data;

  // console.log(a)  // 3

  // const numbers = [1, 2, 3]
  // console.log(numbers.map(number => number * 2))  // 2, 4, 6

  const { data, isLoading, error } = useLocations();

  if (error) {
    //eslint-disable-next-line no-console
    console.error(error);
  }

  // console.log(data);

  return (
    <Layout>
      <Seo templateTitle='Jeff' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='text-4xl font-bold'>Jeff</h1>
            {isLoading ? (
              <Skeleton className='h-8 w-full' />
            ) : !data ? (
              <>No data</>
            ) : (
              data.map((location) => (
                <div key={location.id}>
                  {location.friendly_name} is at {location.latlong}
                </div>
              ))
            )}
          </div>
        </section>
      </main>
    </Layout>
  );
}
