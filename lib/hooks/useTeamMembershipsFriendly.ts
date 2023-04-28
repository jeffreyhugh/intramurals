import {
  SupabaseClient,
  useSupabaseClient,
} from '@supabase/auth-helpers-react';
import useSWR from 'swr';

import { Database } from '@/lib/types/database.types';

export const useTeamMembershipsFriendly = (teamIDs: string[]) => {
  const client = useSupabaseClient<Database>();

  return useSWR(`teamMemberships-${teamIDs.join()}`, () =>
    teamMembershipsFriendlyFetcher(client, teamIDs)
  );
};

export const teamMembershipsFriendlyFetcher = async (
  client: SupabaseClient<Database, 'public'>,
  teamIDs: string[]
) => {
  const { data, error } = await client
    .from('team_memberships_friendly')
    .select('*')
    .in('team_id', teamIDs);

  if (error) {
    throw error;
  }

  return data || [];
};
