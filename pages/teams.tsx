import * as React from 'react';
import toast from 'react-hot-toast';

import { useMyTeams } from '@/lib/hooks/useMyTeams';
import { requireAuth } from '@/lib/requireAuth';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

export default function Page() {
  const teams = useMyTeams();

  if (teams.error) {
    toast.error('Error fetching teams, please check the console');
    //eslint-disable-next-line no-console
    console.error(teams.error);
  }

  return (
    <Layout>
      <Seo templateTitle='My Teams' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>My Teams</h1>
            <div className='mt-6 w-full'>
              {teams.error ? (
                <SomethingWentWrong />
              ) : teams.isLoading ? (
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
