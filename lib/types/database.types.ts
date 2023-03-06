export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json }
  | Json[];

export interface Database {
  public: {
    Tables: {
      admins: {
        Row: {
          created_at: string;
          id: string;
          user_id: string;
        };
        Insert: {
          created_at?: string;
          id?: string;
          user_id: string;
        };
        Update: {
          created_at?: string;
          id?: string;
          user_id?: string;
        };
      };
      events: {
        Row: {
          created_at: string;
          default_location_id: string | null;
          friendly_name: string;
          higher_is_better: boolean;
          icon_url: string | null;
          id: string;
          max_team_size: number;
          max_teams: number;
          meets_on: string | null;
          min_team_size: number;
          preseason_end: string | null;
          preseason_start: string | null;
          registration_end: string;
          registration_start: string;
          time_end: string | null;
          time_start: string | null;
        };
        Insert: {
          created_at?: string;
          default_location_id?: string | null;
          friendly_name: string;
          higher_is_better?: boolean;
          icon_url?: string | null;
          id?: string;
          max_team_size: number;
          max_teams: number;
          meets_on?: string | null;
          min_team_size: number;
          preseason_end?: string | null;
          preseason_start?: string | null;
          registration_end: string;
          registration_start: string;
          time_end?: string | null;
          time_start?: string | null;
        };
        Update: {
          created_at?: string;
          default_location_id?: string | null;
          friendly_name?: string;
          higher_is_better?: boolean;
          icon_url?: string | null;
          id?: string;
          max_team_size?: number;
          max_teams?: number;
          meets_on?: string | null;
          min_team_size?: number;
          preseason_end?: string | null;
          preseason_start?: string | null;
          registration_end?: string;
          registration_start?: string;
          time_end?: string | null;
          time_start?: string | null;
        };
      };
      games: {
        Row: {
          away_score: number;
          away_team_id: string | null;
          created_at: string;
          event_id: string;
          home_score: number;
          home_team_id: string;
          id: string;
          override_location_id: string | null;
          played_at: string;
        };
        Insert: {
          away_score?: number;
          away_team_id?: string | null;
          created_at?: string;
          event_id: string;
          home_score?: number;
          home_team_id: string;
          id?: string;
          override_location_id?: string | null;
          played_at: string;
        };
        Update: {
          away_score?: number;
          away_team_id?: string | null;
          created_at?: string;
          event_id?: string;
          home_score?: number;
          home_team_id?: string;
          id?: string;
          override_location_id?: string | null;
          played_at?: string;
        };
      };
      locations: {
        Row: {
          created_at: string;
          friendly_name: string;
          id: string;
          latlong: [number, number];
        };
        Insert: {
          created_at?: string;
          friendly_name: string;
          id?: string;
          latlong: [number, number];
        };
        Update: {
          created_at?: string;
          friendly_name?: string;
          id?: string;
          latlong?: [number, number];
        };
      };
      team_memberships: {
        Row: {
          created_at: string;
          team_id: string;
          user_id: string;
        };
        Insert: {
          created_at?: string;
          team_id: string;
          user_id: string;
        };
        Update: {
          created_at?: string;
          team_id?: string;
          user_id?: string;
        };
      };
      teams: {
        Row: {
          captain_id: string;
          created_at: string;
          event_id: string;
          friendly_name: string;
          icon_url: string | null;
          id: string;
        };
        Insert: {
          captain_id?: string;
          created_at?: string;
          event_id: string;
          friendly_name: string;
          icon_url?: string | null;
          id?: string;
        };
        Update: {
          captain_id?: string;
          created_at?: string;
          event_id?: string;
          friendly_name?: string;
          icon_url?: string | null;
          id?: string;
        };
      };
    };
    Views: {
      [_ in never]: never;
    };
    Functions: {
      [_ in never]: never;
    };
    Enums: {
      [_ in never]: never;
    };
  };
}
