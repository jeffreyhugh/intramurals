import { useSupabaseClient } from '@supabase/auth-helpers-react';
import { useRouter } from 'next/router';
import * as React from 'react';
import { useForm } from 'react-hook-form';
import { toast } from 'react-hot-toast';
import { TbAlertOctagon } from 'react-icons/tb';

import clsxm from '@/lib/clsxm';
import { firstOrOnly } from '@/lib/firstOrOnly';
import { Database } from '@/lib/types/database.types';

import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

type SignInFormValues = {
  email: string;
  password: string;
};

export default function Page() {
  const client = useSupabaseClient<Database>();
  const [loginError, setLoginError] = React.useState('');
  const [isLoading, setIsLoading] = React.useState(false);
  const router = useRouter();

  const redirectTo = decodeURIComponent(
    firstOrOnly(router.query.redirectTo, '/dashboard')
  );

  const {
    register,
    handleSubmit,
    formState: { errors },
    watch,
  } = useForm<SignInFormValues>();

  const onSubmit = handleSubmit(async (data) => {
    setIsLoading(true);

    const res = await client.auth.signInWithPassword({
      email: data.email,
      password: data.password,
    });

    if (res.error) {
      toast.error('Something went wrong');
      //eslint-disable-next-line no-console
      console.error(res.error);
      setLoginError(res.error.message);
    } else {
      toast.success('Looks good!');
      router.push(redirectTo);
    }

    setIsLoading(false);
  });

  const magicLink = async () => {
    setIsLoading(true);
    const email = watch('email');
    if (email === '') {
      toast.error('Please enter your email');
      setIsLoading(false);
      return;
    }

    const res = await client.auth.signInWithOtp({
      email: email,
      options: {
        emailRedirectTo: `${window.location.origin}/dashboard`,
      },
    });

    if (res.error) {
      toast.error('Something went wrong');
      //eslint-disable-next-line no-console
      console.error(res.error);
    } else {
      toast.success('Check your email for a magic link');
    }

    setIsLoading(false);
  };

  const resetPassword = async () => {
    setIsLoading(true);
    const email = watch('email');
    if (email === '') {
      toast.error('Please enter your email');
      setIsLoading(false);
      return;
    }

    const res = await client.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/reset`,
    });

    if (res.error) {
      toast.error('Something went wrong');
      //eslint-disable-next-line no-console
      console.error(res.error);
    } else {
      toast.success('Check your email for a password reset link');
    }

    setIsLoading(false);
  };

  return (
    <Layout>
      <Seo templateTitle='Sign In' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout'>
            <div className='flex flex-col items-center justify-center'>
              <h1 className='mt-6 text-4xl font-bold'>Sign In</h1>
              <form
                className='form-control mt-4 w-11/12 max-w-lg'
                onSubmit={onSubmit}
              >
                {loginError !== '' ? (
                  <div className='alert alert-error'>
                    <div className='flex'>
                      <TbAlertOctagon />
                      {loginError}
                    </div>
                  </div>
                ) : null}

                <label htmlFor='email' className='label'>
                  <span className='label-text'>Email</span>
                  <span className='label-text-alt'>Required</span>
                </label>
                <input
                  type='email'
                  className={clsxm(
                    'input-bordered input w-full',
                    errors.email && 'input-error'
                  )}
                  placeholder='you@example.com'
                  id='email'
                  {...register('email', {
                    required: 'This field is required',
                  })}
                />
                {errors.email ? (
                  <label htmlFor='email' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.email.message}
                    </span>
                  </label>
                ) : null}

                <label htmlFor='password' className='label'>
                  <span className='label-text'>Password</span>
                  <span className='label-text-alt'>Required</span>
                </label>
                <input
                  type='password'
                  className={clsxm(
                    'input-bordered input w-full',
                    errors.password && 'input-error'
                  )}
                  id='password'
                  {...register('password', {
                    required: 'This field is required',
                  })}
                />
                {errors.password ? (
                  <label htmlFor='password' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.password?.message}
                    </span>
                  </label>
                ) : null}

                <button
                  className={clsxm(
                    'btn-primary btn mt-6',
                    isLoading && 'loading'
                  )}
                  disabled={isLoading}
                  type='submit'
                >
                  Login
                </button>

                <div className='mt-4 flex flex-col gap-4 md:flex-row'>
                  <button
                    onClick={magicLink}
                    className={clsxm(
                      'btn-outline btn flex-grow',
                      isLoading && 'loading'
                    )}
                    disabled={isLoading}
                    type='button'
                  >
                    Email me a link
                  </button>
                  <button
                    onClick={resetPassword}
                    className={clsxm(
                      'btn-outline btn flex-grow',
                      isLoading && 'loading'
                    )}
                    disabled={isLoading}
                    type='button'
                  >
                    Reset my password
                  </button>
                </div>
              </form>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
