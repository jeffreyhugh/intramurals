import { createBrowserSupabaseClient } from '@supabase/auth-helpers-nextjs';
import Link from 'next/link';
import { TbMenu2 } from 'react-icons/tb';

import clsxm from '@/lib/clsxm';

import { SmallLogo } from '@/components/Logo';
import ThemeChanger from '@/components/ThemeChanger';

export default function Header() {
  // children can be a string or JSX
  // className can change the button type
  const supabase = createBrowserSupabaseClient();

  const headerLinks = [
    {
      className: 'btn-ghost ',
      children: <p className='font-black'>Stats</p>,
      href: '/stats',
    },
    {
      className: 'btn-ghost ',
      children: <p className='font-black'>Events</p>,
      href: '/events',
    },
    {
      className: 'btn-ghost ',
      children: <p className='font-black'>Teams</p>,
      href: '/teams',
    },
    {
      className: 'btn-ghost ',
      children: <p className='font-black'>Schedule</p>,
      href: '/schedule',
    },
  ];

  return (
    <div className='navbar sticky top-0 z-50 border-b border-b-neutral/10 bg-white/10 p-4 backdrop-blur-md'>
      <div className='flex w-full justify-between'>
        <div className='dropdown-hover dropdown block md:hidden'>
          <label tabIndex={0} className='btn-ghost btn'>
            <TbMenu2 className='h-5 w-5' />
          </label>
          <ul
            tabIndex={0}
            className='dropdown-content menu rounded-box btn-group w-52 border border-neutral/10 bg-base-100 shadow-xl'
          >
            {headerLinks.map((item) => (
              <li key={item.href}>
                <Link
                  href={item.href}
                  className={clsxm('btn', item.className || 'btn-ghost')}
                >
                  {item.children}
                </Link>
              </li>
            ))}
          </ul>
        </div>
        <Link className='btn btn-ghost normal-case' href='/'>
          <SmallLogo />
          <div className='divider divider-horizontal hidden md:flex' />
          <span className='hidden md:inline'>Intramurals.net</span>
        </Link>
        <div className='flex gap-2'>
          <div className='hidden gap-2 md:flex'>
            {headerLinks.map((item) => (
              <Link
                href={item.href}
                className={clsxm('btn', item.className || 'btn-ghost')}
                key={item.href}
              >
                {item.children}
              </Link>
            ))}
          </div>
          <button
            className={clsxm('btn', 'btn-ghost ' || 'btn-ghost')}
            onClick={() => supabase.auth.signOut()}
          >
            {' '}
            SignOut{' '}
          </button>
          <ThemeChanger />
        </div>
      </div>
    </div>
  );
}
