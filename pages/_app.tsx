import { MDXProvider } from '@mdx-js/react';
import {
  createBrowserSupabaseClient,
  Session,
} from '@supabase/auth-helpers-nextjs';
import { SessionContextProvider } from '@supabase/auth-helpers-react';
import { AppProps } from 'next/app';
import Link from 'next/link';
import { ThemeProvider, useTheme } from 'next-themes';
import { ReactNode, useState } from 'react';
import toast, { ToastBar, Toaster } from 'react-hot-toast';
import { TbX } from 'react-icons/tb';

import '@/styles/globals.css';
import '@/styles/katex.css';

import clsxm from '@/lib/clsxm';

import InlineCode from '@/components/mdx/Code';
import { H1, H2, H3, H4 } from '@/components/mdx/Header';

import { dark, light } from '@/constant/colors';

/**
 * !STARTERCONF info
 * ? `Layout` component is called in every page using `np` snippets. If you have consistent layout across all page, you can add it here too
 */

function MyApp({
  Component,
  pageProps,
}: AppProps<{ initialSession: Session }>) {
  const { theme } = useTheme();

  const components = {
    code: InlineCode,
    pre: ({ children }: { children?: ReactNode }) => <div>{children}</div>,
    a: ({
      children,
      className,
      href,
      ...rest
    }: {
      children?: ReactNode;
      className?: string;
      href?: string;
    }) => (
      <Link
        className={clsxm(className, 'text-inherit')}
        style={{
          fontWeight: 'inherit',
        }}
        href={href || ''}
        target={href && href.startsWith('/') ? '_self' : '_blank'}
        {...rest}
      >
        {children}
      </Link>
    ),
    h1: H1,
    h2: H2,
    h3: H3,
    h4: H4,
  };

  // !STARTERCONF consider using TypeScript for this
  // https://supabase.com/docs/reference/javascript/typescript-support
  const [supabaseClient] = useState(() => createBrowserSupabaseClient());

  return (
    <SessionContextProvider
      supabaseClient={supabaseClient}
      initialSession={pageProps?.initialSession}
    >
      <ThemeProvider>
        <MDXProvider components={components}>
          <Toaster
            toastOptions={{
              style: {
                borderRadius: 'var(--rounded-btn, 0.5rem)',
                backgroundColor: 'hsl(var(--n) / 1)',
                color: 'hsl(var(--nc) / 1)',
              },
              success: {
                iconTheme: {
                  primary: theme === 'light' ? light.success : dark.success,
                  secondary:
                    theme === 'light' ? light['base-100'] : dark['base-100'],
                },
              },
              error: {
                iconTheme: {
                  primary: theme === 'light' ? light.error : dark.error,
                  secondary:
                    theme === 'light' ? light['base-100'] : dark['base-100'],
                },
              },
            }}
          >
            {(t) => (
              <ToastBar toast={t}>
                {({ icon, message }) => (
                  <>
                    {icon}
                    {message}
                    {t.type !== 'loading' && (
                      <button
                        className='btn-ghost btn-xs btn-circle btn m-0 p-0'
                        onClick={() => toast.dismiss(t.id)}
                      >
                        <TbX />
                      </button>
                    )}
                  </>
                )}
              </ToastBar>
            )}
          </Toaster>
          <Component {...pageProps} className='bg-base-100' />
        </MDXProvider>
      </ThemeProvider>
    </SessionContextProvider>
  );
}

export default MyApp;
