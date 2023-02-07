import * as React from 'react';

import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

export default function Page() {
  const code = 500;
  const message = 'Internal Server Error';

  return (
    <Layout>
      <Seo templateTitle={`${code}`} />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <div className='h-c flex items-center justify-center'>
              <div className='flex items-center'>
                <div className='py-8 text-lg font-bold'>{code}</div>
                <div className='divider divider-horizontal' />
                <div className=''>{message}</div>
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
