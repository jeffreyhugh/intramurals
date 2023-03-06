import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useGames = (eventID: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`games-${eventID}`, () => gamesFetcher(client, eventID));
};

export const gamesFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  eventID: string
) => {
  const { data, error } = await client
    .from('games')
    .select('*')
    .eq('event_id', eventID);

  if (error) {
    throw error;
  }

  return data || [];
};
