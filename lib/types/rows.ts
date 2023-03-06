import { Database } from '@/lib/types/database.types';

export type TYPE_ADMIN = Database['public']['Tables']['admins']['Row'];
export type TYPE_EVENT = Database['public']['Tables']['events']['Row'];
export type TYPE_GAME = Database['public']['Tables']['games']['Row'];
export type TYPE_LOCATION = Database['public']['Tables']['locations']['Row'];
export type TYPE_TEAM_MEMBERSHIP =
  Database['public']['Tables']['team_memberships']['Row'];
export type TYPE_TEAM = Database['public']['Tables']['teams']['Row'];
