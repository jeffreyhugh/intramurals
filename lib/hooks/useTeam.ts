import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { firstOrOnly } from '@/lib/firstOrOnly';
import { Database } from '@/lib/types/database.types';
import { TYPE_TEAM } from '@/lib/types/rows';

export const useTeam = (id: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`team-${id}`, () => teamFetcher(client, id));
};

export const teamFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  id: string
) => {
  const { data, error } = await client.from('teams').select('*').eq('id', id);

  if (error) {
    throw error;
  }

  return firstOrOnly(data, {} as TYPE_TEAM);
};
