import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

/*
 * Use this hook to determine which groupchats a user can see
 * It's also good for groupchat names
 */
export const useGroupchats = () => {
  const client = useSupabaseClient<Database>();

  return useSWR('groupchats', () => groupchatsFetcher(client));
};

export const groupchatsFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { data, error } = await client.from('groupchats').select('*');

  if (error) {
    throw error;
  }

  return data || [];
};
