import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useFreeAgents = (eventID: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`freeAgents-${eventID}`, () =>
    freeAgentsFetcher(client, eventID)
  );
};

export const freeAgentsFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  eventID: string
) => {
  const { data, error } = await client.rpc('users_without_team', {
    e_id: eventID,
  });

  if (error) {
    throw error;
  }

  return (data as Database['public']['Tables']['user_metadata']['Row']) || [];
};
