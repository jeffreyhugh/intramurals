import Link from 'next/link';
import * as React from 'react';
import { TbBrandGithub, TbBrandVercel, TbHelp } from 'react-icons/tb';

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
                  <h1 className='h1 mt-4'>Web Starter</h1>
                  <h3 className='h3 mt-4 flex max-w-md flex-wrap gap-2'>
                    Next.js, TypeScript, DaisyUI, TailwindCSS, Supabase, MDX,
                    React Hot Toast, and more
                  </h3>
                  <div className='btn-group btn-group-vertical mt-6'>
                    <Link className='btn' href='/features'>
                      <TbHelp className='mr-2' />
                      All features
                    </Link>
                    <Link
                      className='btn'
                      href='https://github.com/jeffreyhugh/starter'
                    >
                      <TbBrandGithub className='mr-2' />
                      See it on GitHub
                    </Link>
                    <Link
                      className='btn'
                      href='https://vercel.com/new/git/external?repository-url=https%3A%2F%2Fgithub.com%2Fjeffreyhugh%2Fstarter'
                    >
                      <TbBrandVercel className='mr-2' />
                      Deploy on Vercel
                    </Link>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
