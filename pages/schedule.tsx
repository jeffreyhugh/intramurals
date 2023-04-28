import { DateTime } from 'luxon';
import moment from 'moment';
import * as React from 'react';
import { Calendar, momentLocalizer } from 'react-big-calendar';
import { toast } from 'react-hot-toast';

import 'react-big-calendar/lib/css/react-big-calendar.css';

import { useEvents } from '@/lib/hooks/useEvents';
import { useMyEvents } from '@/lib/hooks/useMyEvents';
import { useMyGames } from '@/lib/hooks/useMyGames';
import { useMyTeams } from '@/lib/hooks/useMyTeams';
import { requireAuth } from '@/lib/requireAuth';
import { Database } from '@/lib/types/database.types';

import { EmptyIcon } from '@/components/icons/empty';
import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

import { dark } from '@/constant/colors';

const localizer = momentLocalizer(moment);

type Games = Database['public']['Tables']['games']['Row'];

export default function Page() {
  const sports = useEvents();

  const myTeams = useMyTeams();
  const myEvents = useMyEvents();

  const { data: myGameData, error } = useMyGames();

  if (error) {
    //eslint-disable-next-line no-console
    console.error(error);
    toast.error('Could not fetch game data, please check the console');
  }

  if (!myGameData) {
    toast.error('Could not load game data');
    return null;
  }

  return (
    <Layout>
      <Seo templateTitle='Schedule' />
      <main className='flex flex-grow'>
        <section className='flex flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>Schedule</h1>
            <div className='mt-6 w-full'>
              {sports.error ? (
                <SomethingWentWrong />
              ) : sports.isLoading ? (
                <Skeleton className='h-48 w-full' />
              ) : (
                <>
                  <div className='bg-white p-2'>
                    {myGameData && (
                      <LargeCalendar myGameData={myGameData as Games[]} />
                    )}
                  </div>
                  {!myGameData && myTeams.data && myEvents?.data ? (
                    <div className='ml-auto mr-auto mt-3 w-1/2'>
                      <EmptyIcon />
                      <p className='relative m-auto text-center font-bold text-neutral/5'>
                        no events scheduled :(
                      </p>
                    </div>
                  ) : (
                    <div className=''>
                      <div className='containerp'>
                        <div className='mt-5 rounded-sm bg-neutral/10 p-1'>
                          <h4 className='h4 text-bold'>Upcoming Events</h4>
                        </div>
                        <div className=' m-1 p-2'>
                          {myGameData.map((game, index) => {
                            return (
                              <div
                                className='border-t border-neutral/20'
                                key={index}
                              >
                                <div>
                                  <p>Event on</p>
                                  <p className='ml-3 font-semibold'>
                                    {DateTime.fromISO(
                                      game.played_at || ''
                                    ).toLocaleString(DateTime.DATETIME_FULL)}
                                  </p>
                                  <p>location</p>
                                  <p className='ml-3'>
                                    {game.override_location_id}
                                  </p>
                                </div>
                              </div>
                            );
                          })}
                        </div>
                      </div>
                    </div>
                  )}
                </>
              )}
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

interface MyEvent {
  id: string;
  title: string | null;
  start: string;
  end: string;
}

const LargeCalendar = ({ myGameData }: { myGameData: Games[] }) => {
  //console.log(props)
  const eventStyle = {
    backgroundColor: dark.primary,
    color: 'white',
    fontSize: '12px',
    fontWeight: '',
  };
  //console.log(myGameData)
  const events: MyEvent[] = myGameData.map((game) => ({
    id: game.id,
    start: game.played_at,
    end: game.played_at,
    title: 'event',
  }));

  return (
    <div className=''>
      {myGameData ? (
        <Calendar
          eventPropGetter={() => ({
            className: 'rbc-event',
            style: eventStyle,
          })}
          localizer={localizer}
          defaultDate={new Date()}
          events={events}
          defaultView='month'
          startAccessor='start'
          endAccessor='end'
          style={{ height: 500 }}
        />
      ) : (
        <Skeleton />
      )}
    </div>
  );
};

export const getServerSideProps = requireAuth({});
