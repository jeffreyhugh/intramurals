import * as React from 'react';
import { useForm } from 'react-hook-form';
import { toast } from 'react-hot-toast';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';

type FormValues = {
  firstName: string;
  lastName: string;
  bestAnimal: string;
  bestColor: string;
  phoneNumberIsEven: boolean;
  subscribeToNewsletter: boolean;
};

export default function Page() {
  const {
    register,
    //watch,
    handleSubmit,
    formState: { errors },
  } = useForm<FormValues>();

  const onSubmit = handleSubmit((data) => {
    toast.success('Check the console');
    // eslint-disable-next-line no-console
    console.log(data);
  });

  return (
    <Layout>
      <Seo templateTitle='Forms' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout'>
            <Breadcrumbs />
            <div className='min-h-c'>
              <h1 className='h1'>Forms</h1>
              <form className='form-control mt-6 md:w-128' onSubmit={onSubmit}>
                <div>
                  <label htmlFor='firstName' className='label'>
                    <span className='label-text'>First Name</span>
                    <span className='label-text-alt'>Required</span>
                  </label>
                  <input
                    type='text'
                    className='input-bordered input w-full'
                    placeholder='Joe'
                    id='firstName'
                    {...register('firstName', {
                      required: 'You must give Big Brother your first name',
                    })}
                  />
                  <label htmlFor='firstName' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.firstName?.message}
                    </span>
                  </label>
                </div>

                <div>
                  <label htmlFor='lastName' className='label'>
                    <span className='label-text'>Last Name</span>
                  </label>
                  <input
                    type='text'
                    className='input-bordered input w-full'
                    placeholder='Mama'
                    id='lastName'
                    {...register('lastName')}
                  />
                  <label htmlFor='lastName' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.lastName?.message}
                    </span>
                  </label>
                </div>

                <div>
                  <label htmlFor='bestAnimal' className='label'>
                    <span className='label-text'>Best Animal</span>
                    <span className='label-text-alt'>Required</span>
                  </label>
                  <select
                    className='select-bordered select w-full'
                    placeholder='Mama'
                    id='bestAnimal'
                    {...register('bestAnimal', {
                      required: 'You must choose the best animal',
                    })}
                  >
                    {/* use a zero-width space to prevent the option from being re-chosen through the keyboard */}
                    {/* set value='' for the default, non-chosen option */}
                    <option value='' className='hidden'>
                      &#8203;Choose...
                    </option>
                    <option value='cat' label='Cat' />
                    <option value='dog' label='Dog' />
                    <option value='hamster' label='Hamster' />
                  </select>
                  <label htmlFor='bestAnimal' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.bestAnimal?.message}
                    </span>
                  </label>
                </div>

                <div>
                  <label htmlFor='bestColor' className='label'>
                    <span className='label-text'>Best Color</span>
                    <span className='label-text-alt'>Required</span>
                  </label>

                  <div className='flex items-center'>
                    <input
                      type='radio'
                      className='radio radio-sm checked:bg-info'
                      id='bestColorInfo'
                      value='info'
                      {...register('bestColor', {
                        required: 'You must choose the best color',
                      })}
                    />
                    <label
                      htmlFor='bestColorInfo'
                      className='label ml-2 cursor-pointer'
                    >
                      <span className='label-text text-info'>Info</span>
                    </label>
                  </div>

                  <div className='flex items-center'>
                    <input
                      type='radio'
                      className='radio radio-sm checked:bg-success'
                      id='bestColorSuccess'
                      value='success'
                      {...register('bestColor', {
                        required: 'You must choose the best color',
                      })}
                    />
                    <label
                      htmlFor='bestColorSuccess'
                      className='label ml-2 cursor-pointer'
                    >
                      <span className='label-text text-success'>Success</span>
                    </label>
                  </div>

                  <div className='flex items-center'>
                    <input
                      type='radio'
                      className='radio radio-sm checked:bg-warning'
                      id='bestColorWarning'
                      value='warning'
                      {...register('bestColor', {
                        required: 'You must choose the best color',
                      })}
                    />
                    <label
                      htmlFor='bestColorWarning'
                      className='label ml-2 cursor-pointer'
                    >
                      <span className='label-text text-warning'>Warning</span>
                    </label>
                  </div>

                  <div className='flex items-center'>
                    <input
                      type='radio'
                      className='radio radio-sm checked:bg-error'
                      id='bestColorError'
                      value='error'
                      {...register('bestColor', {
                        required: 'You must choose the best color',
                      })}
                    />
                    <label
                      htmlFor='bestColorError'
                      className='label ml-2 cursor-pointer'
                    >
                      <span className='label-text text-error'>Error</span>
                    </label>
                  </div>

                  <label htmlFor='bestColor' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.bestColor?.message}
                    </span>
                  </label>
                </div>

                <div>
                  <label
                    htmlFor='phoneNumberIsEven'
                    className='label cursor-pointer'
                  >
                    <span className='label-text'>Phone Number</span>
                  </label>
                  <div className='flex items-center'>
                    <input
                      type='checkbox'
                      className='checkbox checkbox-sm'
                      id='phoneNumberIsEven'
                      {...register('phoneNumberIsEven')}
                    />
                    <label
                      htmlFor='phoneNumberIsEven'
                      className='label cursor-pointer'
                    >
                      <span className='label-text ml-2'>
                        My phone number is even
                      </span>
                    </label>
                  </div>
                  <label htmlFor='phoneNumberIsEven' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.phoneNumberIsEven?.message}
                    </span>
                  </label>
                </div>

                <div>
                  <label
                    htmlFor='subscribeToNewsletter'
                    className='label cursor-pointer'
                  >
                    <span className='label-text'>Newsletter</span>
                  </label>
                  <div className='flex items-center'>
                    <input
                      type='checkbox'
                      className='toggle toggle-sm'
                      id='subscribeToNewsletter'
                      {...register('subscribeToNewsletter')}
                    />
                    <label
                      htmlFor='subscribeToNewsletter'
                      className='label cursor-pointer'
                    >
                      <span className='label-text ml-2'>
                        Subscribe to a fake newsletter
                      </span>
                    </label>
                  </div>
                  <label htmlFor='subscribeToNewsletter' className='label'>
                    <span className='label-text-alt text-error'>
                      {errors.subscribeToNewsletter?.message}
                    </span>
                  </label>
                </div>

                <button className='btn-primary btn' type='submit'>
                  Looks good
                </button>

                <button className='btn-outline btn mt-2' type='reset'>
                  Reset
                </button>
              </form>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
