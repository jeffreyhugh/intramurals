import {
  useSessionContext,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import Image from 'next/image';
import * as React from 'react';
import toast from 'react-hot-toast';

import { useMyTeams } from '@/lib/hooks/useMyTeams';
import { requireAuth } from '@/lib/requireAuth';
import { Database } from '@/lib/types/database.types';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

export default function Page() {
  const { session } = useSessionContext();
  const teams = useMyTeams();
  //const myEvents = useMyEvents();
  const supabase = useSupabaseClient<Database>();

  const [selectedFile, setSelectedFile] = React.useState<File | null>(null);

  React.useEffect(() => {
    //eslint-disable-next-line no-console
    //console.log(teams?.data)
    //eslint-disable-next-line no-console
    //console.log(myEvents?.data)
  }, [teams.isLoading]);

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    event.preventDefault();
    const newFile = event.target.files?.[0];
    if (newFile) {
      const reader = new FileReader();
      reader.onload = () => {
        setSelectedFile(newFile);
        supabase.storage
          .from('teamImage')
          .upload(selectedFile?.name as string, selectedFile as File)
          .then((response) => {
            //eslint-disable-next-line no-console
            console.log(response);
          })
          .catch((error) => {
            //eslint-disable-next-line no-console
            console.log(error);
          });
      };
      reader.readAsText(newFile);
    } else {
      setSelectedFile(null);
    }
  };

  if (teams.error) {
    toast.error('Error fetching teams, please check the console');
    //eslint-disable-next-line no-console
    console.error(teams.error);
  }

  return (
    <Layout>
      <Seo templateTitle='My Teams' />

      <main className='flex flex-grow'>
        <section className='flex max-w-full flex-grow'>
          <div className='layout min-h-c'>
            <Breadcrumbs />
            <h1 className='mt-6 text-4xl font-bold'>My Teams</h1>
            <div className='mt-6 w-full'>
              {teams.error ? (
                <SomethingWentWrong />
              ) : teams.isLoading ? (
                <Skeleton className='h-48 w-full' />
              ) : (
                <div className=''>
                  {teams?.data?.map((event, index) => {
                    return (
                      <div
                        key={index}
                        className=' rouoverflow-hidden rounded-t-lg bg-primary shadow-lg'
                      >
                        <div>
                          <h1 className='p-2 font-semibold text-neutral'>
                            {event?.friendly_name}
                          </h1>
                        </div>
                        <div className='flex flex-col content-between items-center justify-evenly rounded-t-lg border  border-neutral-300 bg-base-100 p-5 ring-offset-0'>
                          {event.captain_id == session?.user?.id ? (
                            <div>You are the team captain</div>
                          ) : (
                            <div>user is not captain</div>
                          )}
                          <div className='bg relative flex w-full content-center items-center justify-around text-center'>
                            <div className='align-center align-center ... flex max-h-full flex-wrap content-center items-center items-center justify-center space-x-2  border'>
                              {event.icon_url ? (
                                <Image
                                  width={100}
                                  height={100}
                                  alt='img'
                                  className='relative w-20 rounded-md bg-white p-2'
                                  src={'/svgsports/' + event?.icon_url + '.svg'}
                                />
                              ) : (
                                <div className='w-20'>
                                  upload your teams logo
                                  <input
                                    type='file'
                                    onChange={handleFileChange}
                                  />
                                </div>
                              )}
                            </div>

                            <div>
                              <span>{event?.id}</span>
                              <span> teams registered</span>
                            </div>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}

export const getServerSideProps = requireAuth({});
