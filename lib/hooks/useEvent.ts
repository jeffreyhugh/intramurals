import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { firstOrOnly } from '@/lib/firstOrOnly';
import { Database } from '@/lib/types/database.types';
import { TYPE_EVENT } from '@/lib/types/rows';

export const useEvent = (id: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`event-${id}`, () => eventFetcher(client, id));
};

export const eventFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  id: string
) => {
  const { data, error } = await client.from('events').select('*').eq('id', id);

  if (error) {
    throw error;
  }

  return firstOrOnly(data, {} as TYPE_EVENT);
};
