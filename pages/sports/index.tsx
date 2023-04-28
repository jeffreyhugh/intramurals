import { useSupabaseClient } from '@supabase/auth-helpers-react';
import { DateTime } from 'luxon';
import Image from 'next/image';
import Link from 'next/link';
import * as React from 'react';
import { useForm } from 'react-hook-form';
import { toast } from 'react-hot-toast';

import { useEvents } from '@/lib/hooks/useEvents';
import { useIsAdmin } from '@/lib/hooks/useIsAdmin';
import { requireAuth } from '@/lib/requireAuth';
import { Database } from '@/lib/types/database.types';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

type FormValues = {
  defaultLocationId?: string | null;
  friendlyName: string;
  higherIsBetter?: boolean;
  iconUrl?: string | null;
  maxTeamSize: number;
  maxTeams: number;
  meetsOn?: string | null;
  minTeamSize: number;
  preseasonEnd?: string | null;
  preseasonStart?: string | null;
  registrationEnd: string;
  registrationStart: string;
  timeEnd?: string | null;
  timeStart?: string | null;
  division: string | null;
  eventName: string | null;
};

export default function Page() {
  const sports = useEvents();
  const isAdmin = useIsAdmin();

  if (sports.error) {
    toast.error('Error fetching sports, please check the console');
    //eslint-disable-next-line no-console
    console.error(sports.error);
  }

  const curDate = DateTime.now().toISO() || '0';
  return (
    <Layout>
      <Seo templateTitle='Sports' />

      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Sports</h1>
            <div className='mt-6 w-full'>
              {sports.error ? (
                <SomethingWentWrong />
              ) : sports.isLoading ? (
                <Skeleton className='h-48 w-full' />
              ) : (
                <div className=''>
                  {/* temporary. For viewing purposes */}
                  {isAdmin.data && <Adminform />}
                  <div className='space-between align-items flex flex-col justify-center space-y-12'>
                    <div className='overflow-hidden rounded-t-lg bg-primary shadow-lg'>
                      <div>
                        <h1 className=' p-2 font-semibold text-neutral'>
                          in season
                        </h1>
                      </div>

                      <div className='flex flex-col content-between items-center justify-evenly space-y-5 rounded-t-lg bg-base-100 p-5'>
                        <div className='wrap-no m-2 flex w-full items-center justify-around border-b pb-3 font-bold'>
                          <div>
                            <p>Activity</p>
                          </div>
                          <div>
                            <p>Division</p>
                          </div>
                          <div>
                            <p>Registration</p>
                          </div>
                        </div>
                        {sports?.data?.map((event, index) => {
                          if (curDate > event.registration_end) {
                            //if registration is closed
                            return (
                              <div
                                className='relative flex w-full content-center items-center justify-between space-x-3 text-center'
                                key={index}
                              >
                                <div className='align-center align-center ... flex max-h-full flex-wrap content-center items-center justify-center  space-x-2'>
                                  <Image
                                    width={100}
                                    height={100}
                                    alt='img'
                                    className=' shrink rounded-md bg-white p-2'
                                    src={'svgsports/' + event.icon_url + '.svg'}
                                  />
                                  <p>{event.friendly_name}</p>
                                </div>

                                <div>{event.division}</div>
                                <div>
                                  <span>
                                    {DateTime.fromISO(
                                      event.registration_start
                                    ).toLocaleString({
                                      month: 'long',
                                      day: 'numeric',
                                    })}
                                  </span>
                                  <span> to </span>
                                  <span>
                                    {DateTime.fromISO(
                                      event.registration_end
                                    ).toLocaleString({
                                      month: 'long',
                                      day: 'numeric',
                                    })}
                                  </span>
                                </div>
                              </div>
                            );
                          }
                        })}
                      </div>
                    </div>

                    <div className='overflow-hidden rounded-t-lg bg-primary shadow-lg '>
                      <div>
                        <h1 className='p-2 font-semibold text-neutral'>
                          Open for registration
                        </h1>
                      </div>
                      <div className='flex flex-col content-between items-center justify-evenly space-y-5 rounded-t-lg bg-base-100 p-5'>
                        <div className='wrap-no m-2 flex w-full items-center justify-around border-b pb-3 font-bold'>
                          <div>
                            <p>Activity</p>
                          </div>
                          <div>
                            <p>Division</p>
                          </div>
                          <div>
                            <p>Registration</p>
                          </div>
                        </div>
                        {sports?.data?.map((event, index) => {
                          if (curDate < event.registration_end) {
                            //if registration is still open
                            return (
                              <Link
                                href={`sports/${event.id}`}
                                className='bg hover:scale-101 index-10 relative flex w-full content-center items-center justify-between  space-x-4 text-center transition duration-500 hover:shadow-lg '
                                key={index}
                              >
                                <div className='align-center align-center ... flex max-h-full flex-wrap content-center items-center justify-center  space-x-2'>
                                  <Image
                                    width={100}
                                    height={100}
                                    alt='img'
                                    className='w-15 rounded-md bg-white p-2'
                                    src={'svgsports/' + event.icon_url + '.svg'}
                                  />
                                  <div>
                                    <p className=''>{event.friendly_name}</p>
                                  </div>
                                </div>

                                <div>{event.division}</div>

                                <div>
                                  <span>
                                    {DateTime.fromISO(
                                      event.registration_start
                                    ).toLocaleString({
                                      month: 'long',
                                      day: 'numeric',
                                    })}
                                  </span>
                                  <span> to </span>
                                  <span>
                                    {DateTime.fromISO(
                                      event.registration_end
                                    ).toLocaleString({
                                      month: 'long',
                                      day: 'numeric',
                                    })}
                                  </span>
                                </div>
                              </Link>
                            );
                          }
                        })}
                      </div>
                    </div>

                    <div className='overflow-hidden rounded-t-lg bg-primary shadow-lg '>
                      <div>
                        <h1 className='p-2 font-semibold text-neutral'>
                          Coming Soon
                        </h1>
                      </div>
                      <div className='flex flex-col content-between items-center justify-evenly space-y-5 rounded-t-lg bg-base-100 p-5'>
                        <div className='wrap-no m-2 flex w-full items-center justify-around border-b pb-3 font-bold'>
                          <div>
                            <p>Activity</p>
                          </div>
                          <div>
                            <p>Division</p>
                          </div>
                          <div>
                            <p>Registration</p>
                          </div>
                        </div>
                        {sports?.data?.map((event, index) => {
                          if (event.time_start && event.time_start < curDate) {
                            //if registration is still open
                            return (
                              <div
                                className='bg relative flex w-full content-center items-center justify-between'
                                key={index}
                              >
                                <Link href={`/sports/${event.id}`}>
                                  <div className='align-center relative flex content-center items-center space-x-4'>
                                    <Image
                                      width={100}
                                      height={100}
                                      alt='img'
                                      className='w-20 rounded-md bg-white p-2'
                                      src={
                                        'svgsports/' + event.icon_url + '.svg'
                                      }
                                    />
                                    <p>{event.friendly_name}</p>
                                  </div>{' '}
                                </Link>{' '}
                                <div>{event.division}</div>
                                <div>
                                  <span>
                                    {event.time_start ? (
                                      DateTime.fromISO(
                                        event.time_start
                                      ).toLocaleString({
                                        month: 'long',
                                        day: 'numeric',
                                      })
                                    ) : (
                                      <>TBD</>
                                    )}
                                  </span>
                                </div>
                                <div>
                                  <span>
                                    {DateTime.fromISO(
                                      event.registration_start
                                    ).toLocaleString({
                                      month: 'long',
                                      day: 'numeric',
                                    })}
                                  </span>
                                  <span> to </span>
                                  <span>
                                    {DateTime.fromISO(
                                      event.registration_end
                                    ).toLocaleString({
                                      month: 'long',
                                      day: 'numeric',
                                    })}
                                  </span>
                                </div>
                              </div>
                            );
                          }
                        })}
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

const Adminform = () => {
  const ListOfIcons = [
    'badminto',
    'basketball',
    'esports',
    'footbal',
    'golf',
    'ping-pong',
    'soccer',
    'softball',
    'squash',
    'swimming',
    'tennis',
    'volleyball',
  ];
  const ListOfEvents = [
    '3 Point Shootout',
    '3-on-3 Basketball',
    '4 on 4 Flag Football',
    '4on4 CoRec Volleyball',
    '4v4 Flag Football',
    'All University Cup',
    'Archery',
    'Badminton',
    'Badminton Singles Tournament',
    'Bags/Cornhole Tourney',
    'Basketball',
    'Big Pink Volleyball',
    'Bike Race',
    'Board/Card Games Night',
    'Bowling',
    'Co-Rec Volleyball',
    'CoRec Basketball',
    'Cricket',
    'Cross Country Race',
    'Custom',
    'Cycling Dodgeball',
    'Esports',
    'Esports Tournaments',
    'Flag Football',
    'Floor Hockey',
    'Football',
    'Glow Run',
    'Golf',
    'Golf',
    'Golf 2 Person Scramble',
    'Indoor Soccer',
    'Indoor Soccer Tourney',
    'KanJam/Spikeball Tourn',
    'Kickball',
    'Kickball Tournament',
    'Late Night Climbing',
    'Late Night Dodgeball',
    'MUC Tournaments',
    'NCAA Basketball',
    "NCAA FB Bowl Pick 'Em",
    'New Members',
    'Open Softball Tourney',
    'Outdoor Soccer',
    'Paintball',
    'Paper Airplane Competition',
    'Pickleball',
    'Ping-pong',
    'Powerlifting Competition',
    'PreSeason Basketball Jamboree',
    'Racquetball Doubles',
    'Racquetball Singles',
    'Rave Night @ Welly Events',
    'Rugby',
    'Sand Volleyball',
    'Skills Showcase',
    'Soccer',
    'Softball',
    'Softball',
    'Special Events',
    'Special Olympics Unified Basketball',
    'Special Olympics Unified Floor Hockey Spring Break 5k',
    'Spring Break 5k Summer Softball',
    'Squash',
    'Swimming',
    'Table Tennis Doubles',
    'Table Tennis Singles',
    'Tennis',
    'Tennis',
    'Training',
    'Trap Shoot',
    'Turkey Trot 5k',
    'Ultimate Frisbee',
    'Unified 3v3 Basketball',
    'Unified Flag Football',
    'Unified Kickball',
    'Unified SO Floor Hockey',
    'Unified Soccer',
    'Unified Special Olympics',
    'Unified Special Olympics Indoor Soccer',
    'Video Games',
    'Volleyball',
    'Walleyball Tournament',
    'Wiffle ball',
    'Yard Games',
    'Yard Games League',
  ];

  const supabase = useSupabaseClient<Database>();

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormValues>();

  const onSubmit = handleSubmit(async (data) => {
    const { error } = await supabase.from('events').insert({
      friendly_name: data.friendlyName,
      registration_start: data.registrationStart,
      registration_end: data.registrationEnd,
      preseason_start: data.preseasonStart,
      preseason_end: data.preseasonEnd,
      meets_on: data.meetsOn,
      time_start: data.timeStart,
      time_end: data.timeEnd,
      icon_url: data.iconUrl,
      max_teams: data.maxTeams,
      min_team_size: data.minTeamSize,
      max_team_size: data.maxTeamSize,
      higher_is_better: data.higherIsBetter,
      default_location_id: data.defaultLocationId,
      division: data.division,
      event_name: data.eventName,
    });
    if (error) {
      toast.error('Check the console');
      // eslint-disable-next-line no-console
      console.log(error);
    } else {
      toast.success('Check the console');
      // eslint-disable-next-line no-console
      console.log(data);
    }
  });

  return (
    <div className='align-center flex flex-col items-center justify-center'>
      <div className='min-h-c'>
        <h1 className='h1'>Add Event</h1>
        <form className='form-control mt-6 md:w-128' onSubmit={onSubmit}>
          {/* Pre set list of possible event names */}
          <div>
            <div>
              <h4 className='h4'>Event Name</h4>
            </div>
            <label htmlFor='friendlyName' className='label'>
              <span className='label-text-alt'>Required</span>
            </label>
            <select
              className='select-bordered select w-full'
              placeholder=''
              id='friendlyName'
              {...register('friendlyName', {
                required: 'You need to give your event a name',
              })}
            >
              {/* use a zero-width space to prevent the option from being re-chosen through the keyboard */}
              {/* set value='' for the default, non-chosen option */}
              <option value='' className='hidden'>
                &#8203;Choose...
              </option>
              {ListOfEvents.map((item, index) => (
                <option
                  key={index}
                  value={ListOfEvents[index]}
                  label={ListOfEvents[index]}
                />
              ))}
              <option value='custom' disabled>
                Select an option that best fits your event...
              </option>
            </select>
            <label htmlFor='friendlyName' className='label'>
              <span className='label-text-alt text-error'>
                {errors.friendlyName?.message}
              </span>
            </label>
          </div>

          <div>
            <div>
              <h4 className='h4'>Icon</h4>
            </div>
            <label htmlFor='iconUrl' className='label'>
              <span className='label-text-alt'>Required</span>
            </label>
            <select
              className='select-bordered select w-full'
              placeholder=''
              id='iconUrl'
              {...register('iconUrl', {
                required: 'You need to give your event a name',
              })}
            >
              {/* use a zero-width space to prevent the option from being re-chosen through the keyboard */}
              {/* set value='' for the default, non-chosen option */}
              <option value='' className='hidden'>
                &#8203;Choose...
              </option>
              {ListOfIcons.map((item, index) => (
                <option
                  key={index}
                  value={ListOfIcons[index]}
                  label={ListOfIcons[index]}
                />
              ))}
              <option value='custom' disabled>
                Select an option that best fits your event...
              </option>
            </select>
            <label htmlFor='iconUrl' className='label'>
              <span className='label-text-alt text-error'>
                {errors.iconUrl?.message}
              </span>
            </label>
          </div>

          <div>
            <div>
              <h4 className='h4'>Division</h4>
            </div>
            <label htmlFor='division' className='label'>
              <span className='label-text-alt'>Required</span>
            </label>
            <select
              className='select-bordered select w-full'
              placeholder='Mama'
              id='division'
              {...register('division', {
                required: 'You need to give your event a division',
              })}
            >
              {/* use a zero-width space to prevent the option from being re-chosen through the keyboard */}
              {/* set value='' for the default, non-chosen option */}
              <option value='' className='hidden'>
                &#8203;Choose...
              </option>
              <option value='women' label='Women' />
              <option value='men' label='Men' />
              <option value='open' label='Open' />
              <option value='2 person scramble' label='2 person scramble' />
              <option value='4 person scramble' label='4 person scramble' />
              <option value='unified' label='Unified' />
              <option value='singles' label='Singles' />
              <option value='custom' disabled>
                Select an option that best fits your event...
              </option>
            </select>
            <label htmlFor='division' className='label'>
              <span className='label-text-alt text-error'>
                {errors.division?.message}
              </span>
            </label>
          </div>

          {/* registrate by */}
          <div className=' '>
            <div className='mt-5'>
              <h4 className='h4'>Registration Date</h4>
            </div>
            <div className='border-bt flex flex-wrap justify-between p-2'>
              <div className='flex flex-col flex-wrap'>
                <label className='label' htmlFor='registrationStart'>
                  Registration opens
                </label>
                <input
                  type='datetime-local'
                  id='registrationStart'
                  {...register('registrationStart', {
                    required: 'You must enter a start date',
                  })}
                />
              </div>

              <div className=''>
                <label className='label' htmlFor='registrationEnd'>
                  Registration ends
                </label>
                <input
                  type='datetime-local'
                  id='registrationEnd'
                  {...register('registrationEnd', {
                    required: 'You must enter an end date',
                  })}
                />
              </div>
            </div>
          </div>

          <div className=' '>
            <div className='mt-5'>
              <h4 className='h4'>Preseason</h4>
            </div>
            <div className='border-bt flex flex-wrap justify-between p-2'>
              <div className='flex flex-col'>
                <label className='label' htmlFor='preseasonStart'>
                  Registration opens
                </label>
                <input
                  type='datetime-local'
                  id='preseasonStart'
                  {...register('preseasonStart')}
                />
              </div>

              <div className='flex flex-col'>
                <label className='label' htmlFor='preseasonEnd'>
                  Registration ends
                </label>
                <input
                  type='datetime-local'
                  id='preseasonEnd'
                  {...register('preseasonEnd')}
                />
              </div>
            </div>
          </div>

          <div className=' '>
            <div className='mt-5'>
              <h4 className='h4'>Events starts on</h4>
            </div>
            <div className='border-bt flex flex-wrap justify-between p-2'>
              <div className='flex flex-col'>
                <label className='label' htmlFor='timeStart'>
                  Opening Day
                </label>
                <input
                  type='datetime-local'
                  id='timeStart'
                  {...register('timeStart')}
                />
              </div>

              <div className='flex flex-col'>
                <label className='label' htmlFor='timeEnd'>
                  Last day
                </label>
                <input
                  type='datetime-local'
                  id='timeEnd'
                  {...register('timeEnd')}
                />
              </div>
            </div>
          </div>

          {/* team sizes */}
          <div>
            <div className='mt-5'>
              <h4 className='h4'>Team size</h4>
            </div>
            <div className='no-wrap border-bt flex'>
              <label htmlFor='minTeamSize' className='label'>
                <span className='label-text'>minimum team size</span>
              </label>
              <input
                type='text'
                className='input-bordered input w-full'
                placeholder='10'
                id='minTeamSize'
                {...register('minTeamSize', {
                  required: 'You must enter a minimum team size',
                })}
              />
              <label htmlFor='minTeamSize' className='label'>
                <span className='label-text-alt text-error'>
                  {errors.minTeamSize?.message}
                </span>
              </label>

              <label htmlFor='maxTeamSize' className='label'>
                <span className='label-text'>maximum team size</span>
              </label>
              <input
                type='text'
                className='input-bordered input w-full'
                placeholder='10'
                id='maxTeamSize'
                {...register('maxTeamSize', {
                  required: 'You must enter maximum team size',
                })}
              />
              <label htmlFor='maxTeamSize' className='label'>
                <span className='label-text-alt text-error'>
                  {errors.maxTeamSize?.message}
                </span>
              </label>
            </div>
          </div>

          {/* number of teams */}
          <div>
            <div className='mt-5'>
              <h4 className='h4'>Number of teams</h4>
            </div>
            <div className='no-wrap border-bt flex'>
              <label htmlFor='maxTeams' className='label'>
                <span className='label-text'>
                  Maximum number of teams allowed
                </span>
              </label>
              <input
                type='text'
                className='input-bordered input w-full'
                placeholder='4'
                id='maxTeams'
                {...register('maxTeams', {
                  required:
                    'You must enter the maximum number of teams allowed',
                })}
              />
              <label htmlFor='maxTeams' className='label'>
                <span className='label-text-alt text-error'>
                  {errors.maxTeams?.message}
                </span>
              </label>
            </div>
          </div>

          {/* meets on */}
          <div>
            <div className='mt-5'>
              <h4 className='h4'>Days games are played on</h4>
            </div>
            <label htmlFor='meetsOn' className='label'>
              <span className='label-text'></span>
            </label>
            <input
              type='text'
              className='input-bordered input w-full'
              placeholder='Monday Wenesday Friday'
              id='meetsOn'
              {...register('meetsOn')}
            />
            <label htmlFor='meetsOn' className='label'>
              <span className='label-text-alt text-error'>
                {errors.meetsOn?.message}
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
  );
};

export const getServerSideProps = requireAuth({});
