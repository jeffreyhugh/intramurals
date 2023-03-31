import * as React from 'react';
import { toast } from 'react-hot-toast';

import { useMyEvents } from '@/lib/hooks/useMyEvents';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

export default function Page() {
  const events = useMyEvents();

  if (events.error) {
    toast.error('Error fetching events, please check the console');
    //eslint-disable-next-line no-console
    console.error(events.error);
  }

  return (
    <Layout>
      <Seo templateTitle='Stats' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Stats</h1>
            {events.error ? (
              <SomethingWentWrong />
            ) : events.isLoading ? (
              <Skeleton className='h-48 w-full' />
            ) : (
              <>
                TODO: Make a component for the stats for each event with prop{' '}
                <code>eventID</code>, then use the <code>useGames()</code> hook
                in that component to get the games played and calculate stats.
              </>
            )}
          </div>
        </section>
      </main>
    </Layout>
  );
}
