import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useTeams = (eventID: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`teams-${eventID}`, () => teamsFetcher(client, eventID));
};

export const teamsFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  eventID: string
) => {
  const { data, error } = await client
    .from('teams')
    .select('*')
    .eq('event_id', eventID);

  if (error) {
    throw error;
  }

  return data || [];
};
