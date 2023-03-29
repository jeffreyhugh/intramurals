import { useSupabaseClient } from '@supabase/auth-helpers-react';
import { useRouter } from 'next/router';
import * as React from 'react';
import { toast } from 'react-hot-toast';
import { TbLogout } from 'react-icons/tb';

import { useMetadata } from '@/lib/hooks/useMetadata';
import { requireAuth } from '@/lib/requireAuth';
import { Database } from '@/lib/types/database.types';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  const client = useSupabaseClient<Database>();
  const router = useRouter();

  const metadata = useMetadata();

  if (metadata.error) {
    toast.error('Error fetching metadata, please check the console');
    //eslint-disable-next-line no-console
    console.error(metadata.error);
  }

  return (
    <Layout>
      <Seo templateTitle='Account' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Account</h1>
            <div className='mt-6 w-full'>
              <div className='flex w-full justify-center'>
                <button
                  type='button'
                  className='btn btn-error'
                  onClick={async () => {
                    if (confirm('Are you sure you want to sign out?')) {
                      await client.auth.signOut();
                      router.push('/signin');
                    }
                  }}
                >
                  <TbLogout className='mr-2' />
                  Sign Out
                </button>
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
