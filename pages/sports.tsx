import * as React from 'react';
import { toast } from 'react-hot-toast';

import { useEvents } from '@/lib/hooks/useEvents';
import { requireAuth } from '@/lib/requireAuth';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

export default function Page() {
  const sports = useEvents();

  if (sports.error) {
    toast.error('Error fetching sports, please check the console');
    //eslint-disable-next-line no-console
    console.error(sports.error);
  }

  return (
    <Layout>
      <Seo templateTitle='Sports' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Sports</h1>
            <div className='mt-6 w-full'>
              {sports.error ? (
                <SomethingWentWrong />
              ) : sports.isLoading ? (
                <Skeleton className='h-48 w-full' />
              ) : (
                <>TODO: display data</>
              )}
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
