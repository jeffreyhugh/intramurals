import {
  SupabaseClient,
  useSupabaseClient,
  useUser,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { firstOrOnly } from '@/lib/firstOrOnly';
import { Database } from '@/lib/types/database.types';
import { TYPE_USER_METADATA } from '@/lib/types/rows';

export const useMetadata = () => {
  const user = useUser();
  const client = useSupabaseClient<Database>();

  return useSWR(user ? `user-${user.id}` : null, () =>
    userFetcher(client, user?.id || '')
  );
};

export const userFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  userID: string
) => {
  if (!userID) {
    return {} as TYPE_USER_METADATA;
  }

  const { data, error } = await client
    .from('user_metadata')
    .select('*')
    .eq('id', userID);

  if (error) {
    throw error;
  }

  return firstOrOnly(data, {} as TYPE_USER_METADATA);
};
