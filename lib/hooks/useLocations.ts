import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useLocations = () => {
  const client = useSupabaseClient<Database>();

  return useSWR('locations', () => locationsFetcher(client));
};

export const locationsFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { data, error } = await client.from('locations').select('*');

  if (error) {
    throw error;
  }

  return data || [];
};
