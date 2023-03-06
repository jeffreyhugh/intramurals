import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { firstOrOnly } from '@/lib/firstOrOnly';
import { Database } from '@/lib/types/database.types';
import { TYPE_LOCATION } from '@/lib/types/rows';

export const useLocations = (id: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`location-${id}`, () => locationFetcher(client, id));
};

export const locationFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  id: string
) => {
  const { data, error } = await client
    .from('locations')
    .select('*')
    .eq('id', id);

  if (error) {
    throw error;
  }

  return firstOrOnly(data, {} as TYPE_LOCATION);
};
