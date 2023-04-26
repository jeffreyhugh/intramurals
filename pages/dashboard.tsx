import Image from 'next/image';
import * as React from 'react';
import { PieChart } from 'react-minimal-pie-chart';

import { useMetadata } from '@/lib/hooks/useMetadata';
import { requireAuth } from '@/lib/requireAuth';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  // TODO what data do we need here?

  const data = useMetadata();
  const wins = data?.data?.wins || 0;
  const losses = data?.data?.loses || 0;
  const total = wins + losses;
  const winLossRatio =
    data?.data?.wins && data?.data?.loses
      ? (data.data.wins + data.data.loses) * 100
      : 0;

  const piedata = [
    { title: 'Wins', value: data?.data?.wins || 1, color: '#009944' },
    { title: 'Losses', value: data?.data?.loses || 1, color: '#EA3546' },
  ];

  return (
    <Layout>
      <Seo templateTitle='Dashboard' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'> Dashboard </h1>
            <h2 className='mt-6 text-4xl font-bold'>
              {' '}
              Welcome, {data?.data?.first_name}{' '}
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
                    {' '}
                    Wins{' '}
                  </h1>
                  <div className='bg-dark mt-28 w-full text-4xl'>
                    {' '}
                    {data?.data?.wins ? data?.data?.wins : 0}{' '}
                  </div>
                </div>
                <div className='bg-dark align-center mt-0 flex w-1/3 flex-col content-center justify-start border-2 text-center'>
                  <h1 className='mt-3 text-center text-4xl font-bold'>
                    {' '}
                    Losses{' '}
                  </h1>
                  <div className='bg-dark mt-28 w-full text-4xl'>
                    {' '}
                    {data?.data?.loses ? data?.data?.loses : 0}{' '}
                  </div>
                </div>
                <div className='bg-dark align-center mt-0 flex w-1/3 flex-col content-center justify-start border-2 text-center'>
                  <h1 className='mt-3 text-center text-4xl font-bold'>
                    {' '}
                    Win %{' '}
                  </h1>
                  <div className='bg-dark mt-28 w-full text-4xl'>
                    {' '}
                    {winLossRatio.toFixed(2)}%
                  </div>
                </div>
              </div>

              <PieChart
                className='w-50 mt-12 h-80 flex-auto'
                data={piedata}
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

            {/* <>TODO, profile image insert, wins, loss, w/l ratio, </>
              <>div for profile, div for stats</> */}
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
