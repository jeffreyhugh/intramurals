import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useTeamMemberships = (teamID: string) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`teamMemberships-${teamID}`, () =>
    teamMembershipsFetcher(client, teamID)
  );
};

export const teamMembershipsFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  teamID: string
) => {
  const { data, error } = await client
    .from('team_memberships')
    .select('*')
    .eq('team_id', teamID);

  if (error) {
    throw error;
  }

  return data || [];
};
