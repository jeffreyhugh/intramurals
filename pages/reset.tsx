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

type ResetFormValues = {
  password: string;
  confirm: string;
};

export default function Page() {
  const client = useSupabaseClient<Database>();
  const [formError, setFormError] = React.useState('');
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
  } = useForm<ResetFormValues>();

  const onSubmit = handleSubmit(async (data) => {
    setIsLoading(true);

    const res = await client.auth.updateUser({
      password: data.password,
    });

    if (res.error) {
      toast.error('Something went wrong');
      //eslint-disable-next-line no-console
      console.error(res.error);
      setFormError(res.error.message);
    } else {
      toast.success('Looks good!');
      router.push(redirectTo);
    }

    setIsLoading(false);
  });

  return (
    <Layout>
      <Seo templateTitle='Reset Password' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout'>
            <div className='flex flex-col items-center justify-center'>
              <h1 className='mt-6 text-4xl font-bold'>Reset Password</h1>
              <form
                className='form-control mt-4 w-11/12 max-w-lg'
                onSubmit={onSubmit}
              >
                {formError !== '' ? (
                  <div className='alert alert-error'>
                    <div className='flex'>
                      <TbAlertOctagon />
                      {formError}
                    </div>
                  </div>
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
                  {...register('password', {
                    required: 'This field is required',
                  })}
                />
                {errors.password ? (
                  <label htmlFor='password' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.password.message}
                    </span>
                  </label>
                ) : null}

                <label htmlFor='confirm' className='label'>
                  <span className='label-text'>Confirm</span>
                  <span className='label-text-alt'>Required</span>
                </label>
                <input
                  type='password'
                  className={clsxm(
                    'input-bordered input w-full',
                    errors.confirm && 'input-error'
                  )}
                  {...register('confirm', {
                    required: 'This field is required',
                    validate: {
                      mustMatch: (v) => v === watch('password'),
                    },
                  })}
                />
                {errors.confirm ? (
                  <label htmlFor='confirm' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.confirm.type === 'mustMatch'
                        ? 'Passwords must match'
                        : errors.confirm.message}
                    </span>
                  </label>
                ) : null}

                <button
                  className={clsxm(
                    'btn btn-primary mt-6',
                    isLoading && 'loading'
                  )}
                  disabled={isLoading}
                  type='submit'
                >
                  Submit
                </button>
              </form>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

// export const getServerSideProps = requireAuth({});
