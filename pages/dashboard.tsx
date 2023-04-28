import Image from 'next/image';
import * as React from 'react';
import { toast } from 'react-hot-toast';
import { PieChart } from 'react-minimal-pie-chart';

import { useMetadata } from '@/lib/hooks/useMetadata';
import { requireAuth } from '@/lib/requireAuth';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

import { light } from '@/constant/colors';

export default function Page() {
  // TODO what data do we need here?

  const { data, isLoading, error } = useMetadata();

  if (error) {
    //eslint-disable-next-line no-console
    console.error(error);
    toast.error('Error fetching metadata, please check the console');
  }

  return (
    <Layout>
      <Seo templateTitle='Dashboard' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'> Dashboard </h1>
            {error ? (
              <SomethingWentWrong />
            ) : isLoading || !data ? (
              <div>Loading...</div>
            ) : (
              <>
                <h2 className='mt-6 text-2xl font-bold'>
                  {' '}
                  Welcome, {data.first_name}{' '}
                </h2>
                <div className='bg-dark mt-6 w-full flex-auto justify-between'>
                  <div className='m-5 flex h-28 w-28 justify-center rounded-full bg-primary'>
                    <div className='h-18 w-18 m-2 flex justify-center overflow-hidden  rounded-full bg-white'>
                      <label htmlFor='image-upload'> Upload Image: </label>

                      <Image
                        width={100}
                        height={100}
                        src='/images/stock_Image.png'
                        alt='uploaded'
                        className='ml-3 mt-1 mb-1 w-full'
                      />

                      <div className='m-2 flex h-56 w-56 rounded-full'>
                        {' '}
                        Insert Image Here...
                      </div>
                    </div>
                  </div>
                  <div className='bg-dark mt-1 flex w-full border'>
                    <div className='bg-dark align-center mt-0 flex w-1/3 flex-col content-center justify-start border-2 text-center'>
                      <h1 className='mt-3 text-center text-4xl font-bold'>
                        Wins
                      </h1>
                      <div className='bg-dark mt-28 w-full text-4xl'>
                        {data.wins}
                      </div>
                    </div>
                    <div className='bg-dark align-center mt-0 flex w-1/3 flex-col content-center justify-start border-2 text-center'>
                      <h1 className='mt-3 text-center text-4xl font-bold'>
                        Losses
                      </h1>
                      <div className='bg-dark mt-28 w-full text-4xl'>
                        {data.loses}
                      </div>
                    </div>
                    <div className='bg-dark align-center mt-0 flex w-1/3 flex-col content-center justify-start border-2 text-center'>
                      <h1 className='mt-3 text-center text-4xl font-bold'>
                        Win %
                      </h1>
                      <div className='bg-dark mt-28 w-full text-4xl'>
                        {(
                          ((data.wins || 0) /
                            ((data.wins || 0) + (data.loses || 0))) *
                          100
                        ).toFixed(2)}
                        %
                      </div>
                    </div>
                  </div>

                  <PieChart
                    className='w-50 mt-12 h-80 flex-auto'
                    data={[
                      {
                        title: 'Wins',
                        value: data.wins || 0,
                        color: light.success,
                      },
                      {
                        title: 'Losses',
                        value: data.loses || 0,
                        color: light.error,
                      },
                    ]}
                    lineWidth={100}
                    paddingAngle={0}
                    label={({ dataEntry }) => dataEntry.value - 1}
                    labelStyle={{
                      fontSize: '10px',
                      fontFamily: 'sans-serif',
                      fill: '#fff',
                    }}
                  />
                </div>
              </>
            )}

            {/* <>TODO, profile image insert, wins, loss, w/l ratio, </>
              <>div for profile, div for stats</> */}
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
