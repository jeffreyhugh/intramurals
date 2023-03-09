import { useRouter } from 'next/router';
import * as React from 'react';

import { firstOrOnly } from '@/lib/firstOrOnly';
import { useTeam } from '@/lib/hooks/useTeam';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { MemberList } from '@/components/teamID/MemberList';

export default function Page() {
  const router = useRouter();
  const { teamID } = router.query;
  const _teamID = firstOrOnly(teamID, '');
  const team = useTeam(_teamID);
  const { data, isLoading, error } = team;
  if (error) {
    //eslint-disable-next-line no-console
    console.error(error);
  }

  return (
    <Layout>
      <Seo templateTitle='Team Dashboard' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />

            {isLoading && (
              <div>
                <Skeleton className='h-8 w-full'></Skeleton>
              </div>
            )}
            {data && (
              <div>
                <h1 className='h1'>Team :{data.friendly_name}</h1>
                <MemberList teamID={_teamID} />
              </div>
            )}
          </div>
        </section>
      </main>
    </Layout>
  );
}
