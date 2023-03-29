import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useMyTeams = () => {
  const client = useSupabaseClient<Database>();

  return useSWR('myTeams', () => myTeamsFetcher(client));
};

export const myTeamsFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { data, error } = await client.from('my_teams').select('*');

  if (error) {
    throw error;
  }

  return data || [];
};
