import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

/*
 * Use this hook to figure out who all is in the groupchat
 */
export const useGroupchatMemberships = (groupchatID: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`groupchatMemberships-${groupchatID}`, () =>
    groupchatMembershipsFetcher(client, groupchatID)
  );
};

export const groupchatMembershipsFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  groupchatID: string
) => {
  const { data, error } = await client
    .from('groupchat_memberships_friendly')
    .select('*')
    .eq('groupchat_id', groupchatID);

  if (error) {
    throw error;
  }

  return data || [];
};
