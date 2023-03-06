import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useIsAdmin = () => {
  const client = useSupabaseClient<Database>();

  return useSWR('admin', () => isAdminFetcher(client));
};

export const isAdminFetcher = async (
  client: SupabaseClient<Database, 'public'>
) => {
  const { count, error } = await client
    .from('admins')
    .select('*', { head: true, count: 'exact' });

  if (error) {
    throw error;
  }

  return count ? count > 0 : false;
};
