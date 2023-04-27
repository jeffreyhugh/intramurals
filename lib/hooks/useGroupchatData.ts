import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

/*
 * Use this hook to get messages for the groupchat
 */
export const useGroupchatData = (groupchatID: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(
    groupchatID === '' ? null : `groupchatData-${groupchatID}`,
    () => groupchatDataFetcher(client, groupchatID)
  );
};

export const groupchatDataFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  groupchatID: string
) => {
  const { data, error } = await client
    .from('groupchat_data_friendly')
    .select('*')
    .eq('groupchat_id', groupchatID)
    .order('message_time', { ascending: true });

  if (error) {
    throw error;
  }

  return data || [];
};
