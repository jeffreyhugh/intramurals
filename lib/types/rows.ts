import { Database } from '@/lib/types/database.types';

export type TYPE_ADMIN = Database['public']['Tables']['admins']['Row'];
export type TYPE_EVENT = Database['public']['Tables']['events']['Row'];
export type TYPE_GAME = Database['public']['Tables']['games']['Row'];
export type TYPE_LOCATION = Database['public']['Tables']['locations']['Row'];
export type TYPE_TEAM_MEMBERSHIP =
  Database['public']['Tables']['team_memberships']['Row'];
export type TYPE_TEAM = Database['public']['Tables']['teams']['Row'];
export type TYPE_USER_METADATA =
  Database['public']['Tables']['user_metadata']['Row'];
export type TYPE_GROUPCHAT = Database['public']['Tables']['groupchats']['Row'];

export type TYPE_MY_TEAM = Database['public']['Views']['my_teams']['Row'];
export type TYPE_GROUPCHAT_MEMBERSHIP_FRIENDLY =
  Database['public']['Views']['groupchat_memberships_friendly']['Row'];
export type TYPE_GROUPCHAT_DATA_FRIENDLY =
  Database['public']['Views']['groupchat_data_friendly']['Row'];
