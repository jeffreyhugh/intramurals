import {
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import Image from 'next/image';
import * as React from 'react';
import toast from 'react-hot-toast';

import { useMetadata } from '@/lib/hooks/useMetadata';
import { useMyTeams } from '@/lib/hooks/useMyTeams';
import { requireAuth } from '@/lib/requireAuth';
import { Database } from '@/lib/types/database.types';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';
import { useSWRConfig } from 'swr';

type FileObject = {
  id: number;
  file: File | null;
};

export default function Page() {
  const teams = useMyTeams();
  const {user} = useUser();
  const { mutate } = useSWRConfig()
  
  const supabase = useSupabaseClient<Database>();
  const userMetaData = useMetadata();

  const [fileObject, setFileObject] = React.useState<FileObject>({
    id: -1,
    file: null,
  });

  React.useEffect(() => {
    //eslint-disable-next-line no-console
    //eslint-disable-next-line no-console
    //console.log(myEvents?.data)
  }, [fileObject]);

  const handleFileChange = (
    event: React.ChangeEvent<HTMLInputElement>,
    id: number,
    file: File
  ) => {
    event.preventDefault();
    setFileObject({ id: id, file: file });
  };

  const submitFile = async (id: string) => {
    const ran = Math.floor(Math.random() * (10000 - 1000 + 1) + 1000);
    const { data, error: error_on_update_file } = await supabase.storage
      .from('/teamLogo')
      .upload(id + ran, fileObject.file as File, {
        cacheControl: '3600',
        upsert: true,
      });
    if (error_on_update_file) {
      toast.error(error_on_update_file.message);
    } else {
      const { error: error_on_update_url } = await supabase
        .from('teams')
        .update({
          team_logo_url: `https://iahuzudvedhpvowlsyxy.supabase.co/storage/v1/object/public/teamLogo/${data?.path}`,
        })
        .eq('id', id)
        .select();
      if (error_on_update_url) {
        toast.error(error_on_update_url.message);
      } else {
        toast.success('team photo updated!');
        mutate('myTeams');
        setFileObject({ id: -1, file: null });
      }
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
                  <button
                    onClick={() => {
                      //eslint-disable-next-line no-console
                      console.log(userMetaData.data);
                    }}
                  >
                    Click here{' '}
                  </button>
                  {teams?.data?.map((team, index) => {
                    //console.log(team)
                    return (
                      <div
                        key={index}
                        className=' rouoverflow-hidden rounded-t-lg bg-primary shadow-lg'
                      >
                        <div>
                          <h1 className='p-2 font-semibold text-neutral'>
                            {team?.friendly_name}
                          </h1>
                        </div>
                        <div className='flex flex-col content-between items-center justify-evenly rounded-t-lg border  border-neutral-300 bg-base-100 p-5 ring-offset-0'>
                          {team.captain_id == user.id ? (
                            <div>You are the team captain</div>
                          ) : (
                            <div>user is not captain</div>
                          )}
                          <div className='bg relative flex w-full content-center items-center justify-around text-center'>
                            <div className='align-center align-center ... flex max-h-full flex-wrap content-center items-center items-center justify-center space-x-2  '>
                              {team.icon_url ? (
                                <Image
                                  width={100}
                                  height={100}
                                  alt='img'
                                  className='relative w-20 rounded-md bg-white md:w-32  '
                                  src={team.icon_url as string}
                                />
                              ) : (
                                <div className='appearance-none '>
                                  <label className='block'>
                                    <input
                                      type='file'
                                      id={`file-input-${index}`}
                                      className='hidden'
                                      onChange={(event) => {
                                        const file = event.target.files?.[0];
                                        handleFileChange(
                                          event,
                                          index,
                                          file as File
                                        );
                                      }}
                                    />
                                    <label
                                      className=''
                                      htmlFor={`file-input-${index}`}
                                    >
                                      {fileObject.id == index ? (
                                        <div className='space-y-4'>
                                          <Image
                                            src={URL.createObjectURL(
                                              fileObject.file as File
                                            )}
                                            width={150}
                                            height={150}
                                            className='w-20 rounded-md md:w-32 '
                                            alt='img'
                                          />
                                          <div>
                                            {fileObject.file && (
                                              <button
                                                className='btn btn-xs'
                                                onClick={() =>
                                                  submitFile(team.id as string)
                                                }
                                              >
                                                submit
                                              </button>
                                            )}
                                          </div>
                                        </div>
                                      ) : (
                                        <div>Upload an image</div>
                                      )}
                                    </label>
                                  </label>
                                </div>
                              )}
                            </div>

                            <div>
                              {/* {myEvents?.data &&
                                myEvents?.data?.map((event, index)=>{
                                  if(event.id== team.event_id ){
                                    //console.log(event)
                                    //console.log(team)
                                  } else {
                                    return
                                  }
                                  return (<></>)
                                })
                              } */}
                              <span>{team?.id}</span>
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
