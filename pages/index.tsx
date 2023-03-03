import * as React from 'react';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import { BigLogo } from '@/components/Logo';
import Seo from '@/components/Seo';

// !STARTERCONF -> Select !STARTERCONF and CMD + SHIFT + F
// Before you begin editing, follow all comments with `STARTERCONF`,
// to customize the default configuration.

export default function HomePage() {
  return (
    <Layout>
      {/* <Seo templateTitle='Home' /> */}
      <Seo />

      <main>
        <section className=''>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <div className='hero'>
              <div className='hero-content text-center'>
                <div className='flex max-w-md flex-col items-center justify-center'>
                  <BigLogo />
                  <h1 className='h1 mt-4'>Intramurals.net</h1>
                  <h3 className='h3 mt-4 flex max-w-md flex-wrap gap-2'>
                    Fewer ads than IMLeagues
                  </h3>
                </div>
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
