import { useSupabaseClient, useUser } from '@supabase/auth-helpers-react';
import Image from 'next/image';
import Link from 'next/link';
import * as React from 'react';
import toast from 'react-hot-toast';
import { BsTrash } from 'react-icons/bs';
import { useSWRConfig } from 'swr';

import { useMyTeams } from '@/lib/hooks/useMyTeams';
import { useTeamMembershipsFriendly } from '@/lib/hooks/useTeamMembershipsFriendly';
import { requireAuth } from '@/lib/requireAuth';
import { Database } from '@/lib/types/database.types';

import { Breadcrumbs } from '@/components/layout/Breadcrumbs';
import Layout from '@/components/layout/Layout';
import Seo from '@/components/Seo';
import Skeleton from '@/components/Skeleton';
import { SomethingWentWrong } from '@/components/SomethingWentWrong';

type FileObject = {
  id: number;
  file: File | null;
};

export default function Page() {
  const { mutate } = useSWRConfig();

  const supabase = useSupabaseClient<Database>();
  const user = useUser();

  const teams = useMyTeams();

  const ar = teams?.data?.map((team) => team?.id);
  const teamMemberships = useTeamMembershipsFriendly((ar as string[]) || []);
  //const teamMemberships = [{first_name: "drew"},{first_name: "drew"},{first_name: "drew"},{first_name: "drew"},{first_name: "drew"},{first_name: "drew"}]
  const [fileObject, setFileObject] = React.useState<FileObject>({
    id: -1,
    file: null,
  });

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
                  {teams?.data?.map((team, index) => {
                    //console.log(team)
                    return (
                      <div
                        key={index}
                        className='relative mt-4 overflow-hidden rounded-t-lg bg-primary shadow-lg'
                      >
                        <div className='align-center absolute top-0 right-2 flex content-center space-x-2  p-2'>
                          <div className=''>
                            <Link href={`sports/${team.event_id}`}>
                              event details
                            </Link>
                          </div>
                          <div className='divider divider-horizontal'></div>
                          <button
                            onClick={() =>
                              toast.error(
                                'Contact intramurals@usd.edu to delete your team'
                              )
                            }
                          >
                            <BsTrash />
                          </button>
                        </div>
                        <div>
                          <h1 className='p-2 font-semibold text-neutral'>
                            {team?.friendly_name}
                          </h1>
                        </div>
                        <div className='-t-lg border border-neutral-300 bg-base-100 p-5 ring-offset-0'>
                          <div className='bg relative flex w-full content-center items-center justify-center text-center'>
                            <div className='align-center align-center ... flex min-w-max flex-wrap content-center items-center items-center justify-center space-x-2  '>
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
                            <div className='divider divider-horizontal'></div>
                            {/* Team Data */}

                            <div className='relative flex w-full flex-col self-stretch'>
                              {team.captain_id == user?.id ? (
                                <div className='mb-2 self-start text-xs'>
                                  *you are the captain
                                </div>
                              ) : (
                                <div className='mb-2 self-start text-xs'>
                                  *user is not captain
                                </div>
                              )}
                              <div className='m-3 self-start font-semibold'>
                                <h2 className='p-auto mr-5'>Teamates:</h2>
                              </div>
                              <div className='m-1 flex flex-wrap justify-between space-x-2 text-sm'>
                                {teamMemberships?.data?.map(
                                  (teamfriendly, index) => {
                                    if (teamfriendly.event_id != team.event_id)
                                      return;
                                    return (
                                      <div key={index} className=''>
                                        <p className=''>
                                          {teamfriendly.first_name}
                                        </p>
                                      </div>
                                    );
                                  }
                                )}

                                <div className='justify-end self-end rounded-md bg-neutral-300 p-1 text-xs font-light text-success'>
                                  {teamMemberships?.data?.reduce(
                                    (acc, obj) =>
                                      acc +
                                      Object.values(obj).filter(
                                        (val) => val === team.id
                                      ).length,
                                    0
                                  )}
                                  {/* TODO: show Maximum */}
                                </div>
                                <div className='relative flex w-full flex-col self-stretch'>
                                  <div className='m-3 mr-5 self-start font-semibold'>
                                    Season starts:{' '}
                                  </div>
                                  <div className='self-start'>
                                    {/* TODO: show season start */}
                                  </div>
                                  <div className='mt-5 underline'>
                                    {' '}
                                    <Link href='/schedule'>
                                      Click here to view play time!
                                    </Link>{' '}
                                  </div>
                                </div>
                              </div>
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
