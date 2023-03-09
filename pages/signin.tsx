//import styles from './styles/login.module.css'
import {
  useSessionContext,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import { Auth } from '@supabase/auth-ui-react';
import { ThemeSupa } from '@supabase/auth-ui-shared';
import Router from 'next/router';
import { useEffect, useState } from 'react';

import { SmallLogo } from '@/components/Logo';

const radii = ['5px', '10px', '20px'] as const;

function SignIn() {
  const supabase = useSupabaseClient();
  const { isLoading, session } = useSessionContext();

  const [borderRadius] = useState(radii[1] as string);
  const [theme] = useState('dark');
  //const router = useRouter();

  useEffect(() => {
    if (isLoading == false && session) {
      Router.push('/home');
    }
  }, [isLoading, session]);

  // console.log(session)
  return (
    <div className='dark:bg-scale-200 bg-scale-100 relative py-2 pb-16'>
      <div className='sm:py-18 gap container relative mx-auto grid grid-cols-1 px-6   md:gap-16 md:py-24 lg:gap-16 lg:px-16 lg:py-24 xl:px-20'>
        <div className='relative col-span-12 mb-16 md:col-span-7 md:mb-0 lg:col-span-6'>
          <div className='relative bg-zinc-900 lg:mx-auto lg:max-w-md'>
            <div className='container-redshadow'>
              <div className='border-scale-400 bg-scale-300 relative rounded-xl px-8 py-12 drop-shadow-sm'>
                <div className='mb-6 flex flex-col gap-6'>
                  <div className='flex items-center gap-3'>
                    <h1 className='text-scale-1200 text-2xl'>
                      <SmallLogo /> intramurals
                    </h1>
                  </div>
                  <p className='text-scale-1100 text-auth-widget-test'>
                    Sign in to access Intramurals
                  </p>
                </div>
                <Auth
                  supabaseClient={supabase}
                  appearance={{
                    theme: ThemeSupa,
                    style: {
                      button: {
                        borderRadius: borderRadius,
                        borderColor: 'rgba(0,0,0,0)',
                      },
                    },
                    variables: {
                      default: {
                        colors: {
                          brand: '#d21533', //set to primary
                          brandAccent: `#a10729`, //set to secondary
                        },
                      },
                    },
                  }}
                  providers={['apple', 'google', 'github']}
                  theme={theme}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default SignIn;
