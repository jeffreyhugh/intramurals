import { useSupabaseClient, useUser } from '@supabase/auth-helpers-react';
import { DateTime } from 'luxon';
import Image from 'next/image';
import { useRouter } from 'next/router';
import * as React from 'react';
import { useForm } from 'react-hook-form';
import toast from 'react-hot-toast';

import { useEvent } from '@/lib/hooks/useEvent';
import { useMyTeams } from '@/lib/hooks/useMyTeams';
import { useTeams } from '@/lib/hooks/useTeams';
import { requireAuth } from '@/lib/requireAuth';
import { Database } from '@/lib/types/database.types';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

import { eventTerms } from '@/constant/terms';

type FormValues = {
  friendly_name: string;
  agreed: boolean;
};
export default function Page() {
  const teams = useMyTeams();
  const router = useRouter();
  const user = useUser();

  const { eventid } = router.query;
  const supabase = useSupabaseClient<Database>();

  const eventDetails = useEvent(eventid as string);
  const eventTeams = useTeams(eventid as string);
  //const teamMembership = useTeamMemberships();

  const [toggleDroppdown, setToggleDropDown] = React.useState(false);

  if (teams.error) {
    toast.error('Error fetching teams, please check the console');
    //eslint-disable-next-line no-console
    console.error(teams.error);
  }

  const { register, handleSubmit } = useForm<FormValues>();

  const onSubmit = handleSubmit(async (data) => {
    //check if captain already has a team
    if (
      eventTeams?.data?.some((obj) =>
        obj.captain_id.includes(user?.id as string)
      )
    ) {
      toast.error('You are already in this event');

      return;
    }

    const { error } = await supabase.from('teams').insert({
      event_id: eventid as string,
      friendly_name: data.friendly_name,
      captain_id: user?.id,
    });
    if (error) {
      toast.error('there was a problem');
    } else {
      toast.success('Success');
    }
    setToggleDropDown(!toggleDroppdown);
  });

  //   const curDate = DateTime.now().toISO() || '0';
  return (
    <Layout>
      <Seo templateTitle='My Teams' />

      <main className='flex flex-grow  '>
        <section className='flex max-w-full flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Teams</h1>
            <div className='mt-6 w-full'>
              {teams.error ? (
                <SomethingWentWrong />
              ) : teams.isLoading ? (
                <Skeleton className='h-48 w-full' />
              ) : (
                <>
                  <div>
                    <div className=' rouoverflow-hidden rounded-t-lg bg-primary shadow-lg'>
                      <div>
                        <h1 className='p-2 font-semibold text-neutral'>
                          Selected
                        </h1>
                      </div>
                      <div className='flex flex-col content-between items-center justify-evenly rounded-t-lg border  border-neutral-300 bg-base-100 p-5 ring-offset-0'>
                        <div className='bg relative flex w-full content-center items-center justify-around text-center'>
                          <div className='align-center align-center ... flex max-h-full flex-wrap content-center items-center items-center justify-center  space-x-2'>
                            <Image
                              width={100}
                              height={100}
                              alt='img'
                              className='relative w-20 rounded-md bg-white p-2'
                              src={
                                '/svgsports/' +
                                eventDetails?.data?.icon_url +
                                '.svg'
                              }
                            />
                            <div className='relative'>
                              <p>{eventDetails?.data?.friendly_name}</p>
                            </div>
                          </div>
                          <div>{eventDetails?.data?.division}</div>
                          <div>
                            <span>{eventTeams?.data?.length}</span>
                            <span> teams registered</span>
                          </div>
                        </div>
                      </div>
                    </div>
                    {/* <div className='sm:block hidden'>
                            <div className=''>
                                <h2 className='h2'>Details</h2>
                                <div className='fle'>
                                </div>
                            </div>    
                        </div> */}
                    <div className=''>
                      <div className=''>
                        <h2 className='h2 mt-3'>Details</h2>
                        <div className='align-center justifty-center flex flex-col items-center space-y-2 text-center'>
                          <div>
                            <h4 className='h4 '>
                              Event:
                              <span className='p-5'>
                                {eventDetails?.data?.friendly_name}
                              </span>
                            </h4>
                          </div>
                          <div>
                            <h4 className='h4 '>
                              Last day to register:
                              <span className='p-5'>
                                {DateTime.fromISO(
                                  eventDetails?.data?.registration_end as string
                                ).toLocaleString(DateTime.DATETIME_FULL)}
                              </span>
                            </h4>
                          </div>
                          <div>
                            <h4 className='h4 '>
                              Maximum team sizes:
                              <span className='p-5'>
                                {eventDetails?.data?.max_team_size}
                              </span>
                            </h4>
                          </div>
                          <div>
                            <h4 className='h4 '>
                              Minimum team sizes:
                              <span className='p-5'>
                                {eventDetails?.data?.min_team_size}
                              </span>
                            </h4>
                          </div>
                          <div>
                            <h4 className='h4 '>
                              Division:
                              <span className='p-5'>
                                {eventDetails?.data?.division}
                              </span>
                            </h4>
                          </div>

                          {eventDetails?.data?.time_start && (
                            <div>
                              <h4 className='h4 '>
                                Season begins on:
                                <span className='p-5'>
                                  {DateTime.fromISO(
                                    eventDetails?.data?.time_start as string
                                  ).toFormat('LLL dd')}
                                </span>
                              </h4>
                            </div>
                          )}
                          {eventDetails?.data?.time_end && (
                            <div>
                              <h4 className='h4 '>
                                Season ends:
                                <span className='p-5'>
                                  {DateTime.fromISO(
                                    eventDetails?.data?.time_end as string
                                  ).toFormat('LLL dd')}
                                </span>
                              </h4>
                            </div>
                          )}
                          {eventDetails?.data?.meets_on && (
                            <div>
                              <h4 className='h4 '>
                                Meets on:
                                <span className='p-5'>
                                  {eventDetails?.data?.meets_on}
                                </span>
                              </h4>
                            </div>
                          )}
                          {eventDetails?.data?.preseason_start && (
                            <div>
                              <h4 className='h4 '>
                                Preaseason starts:
                                <span className='p-5'>
                                  {DateTime.fromISO(
                                    eventDetails?.data
                                      ?.preseason_start as string
                                  ).toFormat('LLL dd')}
                                </span>
                              </h4>
                            </div>
                          )}
                          {eventDetails?.data?.preseason_end && (
                            <div>
                              <h4 className='h4 '>
                                Preseason ends:
                                <span className='p-5'>
                                  {DateTime.fromISO(
                                    eventDetails?.data?.preseason_end as string
                                  ).toFormat('LLL dd')}
                                </span>
                              </h4>
                            </div>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>

                  <div className='mt-10 rounded-md  border border-neutral-300'>
                    <h1 className='m-6 text-2xl font-bold '>Create a team</h1>
                    <div className='white'>
                      <button
                        onClick={() => setToggleDropDown(!toggleDroppdown)}
                        className='btn m-5 border-none bg-primary hover:bg-secondary'
                      >
                        Create team
                      </button>
                    </div>

                    <div
                      className={
                        !toggleDroppdown
                          ? 'hidden'
                          : 'align-center flex justify-center'
                      }
                    >
                      <div className='align-between m-auto flex flex-col items-center justify-center border border-neutral-300 p-4'>
                        <form className='p-auto' onSubmit={onSubmit}>
                          <label htmlFor='friendly_name' className='label'>
                            <span className='label-text'>Team Name</span>
                            <span className='label-text-alt'>Required</span>
                          </label>
                          <input
                            type='text'
                            className='input-bordered input w-full'
                            placeholder='Team 1'
                            id='riendly_name'
                            {...register('friendly_name', {
                              required: 'You need to give your team a name',
                            })}
                          />

                          <div className='mt-4 mb-4 h-32 w-2/4 overflow-scroll border border-neutral-300'>
                            <h2 className='semi-bold text-xl'>
                              Terms of service
                            </h2>
                            <p>{eventTerms}</p>
                            <div className='form-control'>
                              <label className='agreed label flex cursor-pointer justify-center space-x-5 '>
                                <span className='label-text'>Agree</span>
                                <input
                                  type='checkbox'
                                  className='checkbox-neutral checkbox'
                                  {...register('agreed', {
                                    required:
                                      'You need to give your team a name',
                                  })}
                                />
                              </label>
                            </div>
                          </div>
                          <button
                            className='btn btn-primary relative'
                            type='submit'
                          >
                            Looks good
                          </button>
                        </form>
                      </div>
                    </div>
                  </div>

                  <div>
                    <div className='mt-2 rounded-md  border border-neutral-300'>
                      <h1 className='m-6 text-2xl font-bold'>Join a team</h1>
                      <div className='m-auto mb-5  flex w-11/12 justify-around md:w-4/5'>
                        {eventTeams?.data?.length == 0 ? (
                          <div>
                            <h4 className='text-xl'>
                              There are currently no teams to join in this
                              event!
                            </h4>
                          </div>
                        ) : (
                          eventTeams?.data?.map((team, index) => {
                            return (
                              <div
                                key={index}
                                className='bg-primary-200 align-center flex w-full flex-col items-center justify-between rounded-sm border border-neutral-200 p-5'
                              >
                                <div className='self-start'>
                                  <h4 className='h4'>{team.friendly_name}</h4>
                                </div>
                                <div className='align-center flex w-full items-center justify-between'>
                                  <div>
                                    Team size 1/4{' '}
                                    <p className='text-xs'>
                                      {' '}
                                      *max team size{' '}
                                      {eventDetails?.data?.max_team_size}
                                    </p>
                                  </div>
                                  <div className='flex flex-col space-y-2'>
                                    <button className='btn btn-xs border-none bg-neutral-800 text-white'>
                                      view Team
                                    </button>
                                    <button className='btn btn-xs border-none bg-neutral-800 text-white'>
                                      request to join
                                    </button>
                                  </div>
                                </div>
                              </div>
                            );
                          })
                        )}
                      </div>
                    </div>
                  </div>
                  <div>
                    <div className='mt-2 rounded-md border border-neutral-300 '>
                      <h1 className='m-6 text-2xl font-bold'>All teams</h1>
                      <div className='m-10 flex justify-around'>
                        {eventTeams?.data?.length == 0 ? (
                          <div className='align-center m-2 flex flex-col items-center justify-center'>
                            <h4 className='text-xl'>
                              There are currenlty no teams
                            </h4>
                          </div>
                        ) : (
                          eventTeams?.data?.map((team, index) => {
                            return (
                              <div key={index}>
                                <div className='align-center flex items-center justify-between'>
                                  {team.friendly_name}
                                </div>
                              </div>
                            );
                          })
                        )}
                      </div>
                    </div>
                  </div>
                </>
              )}
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
