import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useMyEvents = () => {
  const client = useSupabaseClient<Database>();

  return useSWR('myEvents', () => myEventsFetcher(client));
};

export const myEventsFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { data, error } = await client.from('my_events').select('*');

  if (error) {
    throw error;
  }

  return data || [];
};
