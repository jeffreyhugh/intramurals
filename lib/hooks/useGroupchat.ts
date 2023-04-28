import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';
import { TYPE_GROUPCHAT } from '@/lib/types/rows';

/*
 * Use this hook to determine a groupchat's name
 */
export const useGroupchat = (id: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR('groupchats', () => groupchatsFetcher(client, id));
};

export const groupchatsFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  id: string
) => {
  const { data, error } = await client
    .from('groupchats')
    .select('*')
    .eq('id', id)
    .limit(1)
    .single();

  if (error) {
    throw error;
  }

  return data || ({} as TYPE_GROUPCHAT);
};
