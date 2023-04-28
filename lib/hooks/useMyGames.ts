import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useMyGames = () => {
  const client = useSupabaseClient<Database>();

  return useSWR('myGames', () => myGamesFetcher(client));
};

export const myGamesFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { data, error } = await client.from('my_games').select('*');

  if (error) {
    throw error;
  }

  return data || [];
};
