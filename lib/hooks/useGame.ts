import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { firstOrOnly } from '@/lib/firstOrOnly';
import { Database } from '@/lib/types/database.types';
import { TYPE_GAME } from '@/lib/types/rows';

export const useGame = (id: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`game-${id}`, () => teamsFetcher(client, id));
};

export const teamsFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  id: string
) => {
  const { data, error } = await client.from('games').select('*').eq('id', id);

  if (error) {
    throw error;
  }

  return firstOrOnly(data, {} as TYPE_GAME);
};
