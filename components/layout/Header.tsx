import { ReactNode } from '@mdx-js/react/lib';
import { useUser } from '@supabase/auth-helpers-react';
import Link from 'next/link';
import { TbMenu2, TbUser } from 'react-icons/tb';

import clsxm from '@/lib/clsxm';
import { useIsAdmin } from '@/lib/hooks/useIsAdmin';

import { SmallLogo } from '@/components/Logo';
import ThemeChanger from '@/components/ThemeChanger';

type HeaderLink = {
  className?: string;
  children: ReactNode;
  href: string;
};

export default function Header() {
  // children can be a string or JSX
  // className can change the button type

  let headerLinks: HeaderLink[] = [];

  const user = useUser();
  const isAdmin = useIsAdmin();

  // is loading, help reduce cumulative layout shift
  if (isAdmin.isLoading) {
    headerLinks = [];
  }

  // if the user is logged in and is an admin
  // user: check if a session exists
  // isAdmin.isLoading: could be fetching admin status, default to false
  // isAdmin.data: true if user is an admin
  else if (user && !isAdmin.isLoading && isAdmin.data) {
    headerLinks = [
      {
        className: 'btn-ghost',
        children: 'Dashboard',
        href: '/dashboard',
      },
      {
        className: 'btn-ghost',
        children: <TbUser className='h-5 w-5' title='Account' />,
        href: '/account',
      },
    ];
  }

  // if the user is logged in but not an admin
  else if (user) {
    headerLinks = [
      {
        className: 'btn-ghost',
        children: 'Dashboard',
        href: '/dashboard',
      },
      {
        className: 'btn-ghost',
        children: 'Sports',
        href: '/sports',
      },
      {
        className: 'btn-ghost',
        children: 'My Teams',
        href: '/teams',
      },
      {
        className: 'btn-ghost',
        children: 'Schedule',
        href: '/schedule',
      },
      {
        className: 'btn-ghost',
        children: 'Stats',
        href: '/stats',
      },
      {
        className: 'btn-ghost',
        children: <TbUser className='h-5 w-5' title='Account' />,
        href: '/account',
      },
    ];
  }

  // not logged in
  else {
    headerLinks = [
      {
        className: 'btn-primary',
        children: 'Sign In',
        href: '/signin',
      },
    ];
  }

  return (
    <div className='navbar sticky top-0 z-50 border-b border-b-neutral/10 bg-white/10 p-4 backdrop-blur-md'>
      <div className='flex w-full justify-between'>
        <div className='dropdown dropdown-hover block md:hidden'>
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
        <Link className='btn-ghost btn normal-case' href='/'>
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
          <ThemeChanger />
        </div>
      </div>
    </div>
  );
}
