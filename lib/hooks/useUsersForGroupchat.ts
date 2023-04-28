import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useUsersForGroupchat = () => {
  const client = useSupabaseClient<Database>();

  return useSWR(`users`, () => usersForGroupchatFetcher(client));
};

export const usersForGroupchatFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { data, error } = await client.from('user_metadata').select('*');

  if (error) {
    throw error;
  }

  return data || [];
};
