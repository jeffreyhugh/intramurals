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
          division: string | null;
          event_name: string | null;
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
          division?: string | null;
          event_name?: string | null;
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
          division?: string | null;
          event_name?: string | null;
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
      groupchat_data: {
        Row: {
          content: string;
          created_at: string;
          from_user_id: string;
          id: string;
          to_group_id: string;
        };
        Insert: {
          content: string;
          created_at?: string;
          from_user_id: string;
          id?: string;
          to_group_id: string;
        };
        Update: {
          content?: string;
          created_at?: string;
          from_user_id?: string;
          id?: string;
          to_group_id?: string;
        };
      };
      groupchat_memberships: {
        Row: {
          created_at: string;
          groupchat_id: string;
          user_id: string;
        };
        Insert: {
          created_at?: string;
          groupchat_id: string;
          user_id: string;
        };
        Update: {
          created_at?: string;
          groupchat_id?: string;
          user_id?: string;
        };
      };
      groupchats: {
        Row: {
          created_at: string;
          friendly_name: string;
          id: string;
        };
        Insert: {
          created_at?: string;
          friendly_name: string;
          id?: string;
        };
        Update: {
          created_at?: string;
          friendly_name?: string;
          id?: string;
        };
      };
      locations: {
        Row: {
          created_at: string;
          friendly_name: string;
          id: string;
          latlong: unknown;
        };
        Insert: {
          created_at?: string;
          friendly_name: string;
          id?: string;
          latlong: unknown;
        };
        Update: {
          created_at?: string;
          friendly_name?: string;
          id?: string;
          latlong?: unknown;
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
          id: string;
          team_logo_url: string | null;
        };
        Insert: {
          captain_id?: string;
          created_at?: string;
          event_id: string;
          friendly_name: string;
          id?: string;
          team_logo_url?: string | null;
        };
        Update: {
          captain_id?: string;
          created_at?: string;
          event_id?: string;
          friendly_name?: string;
          id?: string;
          team_logo_url?: string | null;
        };
      };
      user_metadata: {
        Row: {
          created_at: string;
          first_name: string;
          id: string;
          last_name: string | null;
          loses: number | null;
          pfp_url: string | null;
          student_id: string;
          ties: number | null;
          wins: number | null;
        };
        Insert: {
          created_at?: string;
          first_name: string;
          id: string;
          last_name?: string | null;
          loses?: number | null;
          pfp_url?: string | null;
          student_id: string;
          ties?: number | null;
          wins?: number | null;
        };
        Update: {
          created_at?: string;
          first_name?: string;
          id?: string;
          last_name?: string | null;
          loses?: number | null;
          pfp_url?: string | null;
          student_id?: string;
          ties?: number | null;
          wins?: number | null;
        };
      };
    };
    Views: {
      groupchat_data_friendly: {
        Row: {
          content: string | null;
          email: string | null;
          first_name: string | null;
          groupchat_id: string | null;
          last_name: string | null;
          member_since: string | null;
          message_time: string | null;
          pfp_url: string | null;
          student_id: string | null;
          to_group_id: string | null;
          user_id: string | null;
        };
      };
      groupchat_memberships_friendly: {
        Row: {
          email: string | null;
          first_name: string | null;
          groupchat_id: string | null;
          last_name: string | null;
          member_since: string | null;
          pfp_url: string | null;
          student_id: string | null;
          user_id: string | null;
        };
      };
      my_events: {
        Row: {
          created_at: string | null;
          default_location_id: string | null;
          friendly_name: string | null;
          higher_is_better: boolean | null;
          icon_url: string | null;
          id: string | null;
          max_team_size: number | null;
          max_teams: number | null;
          meets_on: string | null;
          min_team_size: number | null;
          preseason_end: string | null;
          preseason_start: string | null;
          registration_end: string | null;
          registration_start: string | null;
          time_end: string | null;
          time_start: string | null;
        };
        Insert: {
          created_at?: string | null;
          default_location_id?: string | null;
          friendly_name?: string | null;
          higher_is_better?: boolean | null;
          icon_url?: string | null;
          id?: string | null;
          max_team_size?: number | null;
          max_teams?: number | null;
          meets_on?: string | null;
          min_team_size?: number | null;
          preseason_end?: string | null;
          preseason_start?: string | null;
          registration_end?: string | null;
          registration_start?: string | null;
          time_end?: string | null;
          time_start?: string | null;
        };
        Update: {
          created_at?: string | null;
          default_location_id?: string | null;
          friendly_name?: string | null;
          higher_is_better?: boolean | null;
          icon_url?: string | null;
          id?: string | null;
          max_team_size?: number | null;
          max_teams?: number | null;
          meets_on?: string | null;
          min_team_size?: number | null;
          preseason_end?: string | null;
          preseason_start?: string | null;
          registration_end?: string | null;
          registration_start?: string | null;
          time_end?: string | null;
          time_start?: string | null;
        };
      };
      my_games: {
        Row: {
          away_score: number | null;
          away_team_id: string | null;
          created_at: string | null;
          event_id: string | null;
          home_score: number | null;
          home_team_id: string | null;
          id: string | null;
          override_location_id: string | null;
          played_at: string | null;
        };
        Insert: {
          away_score?: number | null;
          away_team_id?: string | null;
          created_at?: string | null;
          event_id?: string | null;
          home_score?: number | null;
          home_team_id?: string | null;
          id?: string | null;
          override_location_id?: string | null;
          played_at?: string | null;
        };
        Update: {
          away_score?: number | null;
          away_team_id?: string | null;
          created_at?: string | null;
          event_id?: string | null;
          home_score?: number | null;
          home_team_id?: string | null;
          id?: string | null;
          override_location_id?: string | null;
          played_at?: string | null;
        };
      };
      my_teams: {
        Row: {
          captain_id: string | null;
          created_at: string | null;
          event_id: string | null;
          friendly_name: string | null;
          icon_url: string | null;
          id: string | null;
        };
        Insert: {
          captain_id?: string | null;
          created_at?: string | null;
          event_id?: string | null;
          friendly_name?: string | null;
          icon_url?: string | null;
          id?: string | null;
        };
        Update: {
          captain_id?: string | null;
          created_at?: string | null;
          event_id?: string | null;
          friendly_name?: string | null;
          icon_url?: string | null;
          id?: string | null;
        };
      };
      team_memberships_friendly: {
        Row: {
          captain_id: string | null;
          event_id: string | null;
          first_name: string | null;
          last_name: string | null;
          pfp_url: string | null;
          team_friendly_name: string | null;
          team_id: string | null;
          team_logo_url: string | null;
          user_id: string | null;
        };
      };
    };
    Functions: {
      users_without_team: {
        Args: { e_id: string };
        Returns: unknown;
      };
    };
    Enums: {
      [_ in never]: never;
    };
  };
}
