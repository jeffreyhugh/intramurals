import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useEvents = () => {
  const client = useSupabaseClient<Database>();

  return useSWR('events', () => eventsFetcher(client));
};

export const eventsFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { data, error } = await client.from('events').select('*');

  if (error) {
    throw error;
  }

  return data || [];
};
