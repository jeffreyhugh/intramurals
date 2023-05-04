# Intramurals

## Purpose

To make a replacement for IMLeagues with fewer ads.

## Recreate

### Backend

To recreate the backend, create a project on [Supabase](https://supabase.com).
Run `schema.sql` in the new project (it's just a Postgres script) to recreate the database schema (without data).
There will be some errors (because the default "blank" project has all the auth set up), but the important stuff should succeed.

### Frontend (Local)

Clone the repository, then run `yarn` to install dependencies.
This will also set up Git hooks.

After installing dependencies, copy `.env.example` to `.env.local` and fill in `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` with values from the Supabase project.

Finally, run `yarn dev` to start the development server.

### Frontend (Production)

We used [Vercel](https://vercel.com) to host the frontend.
Sign in with GitHub, link the repo, and watch the deployment happen automatically whenever changes occur on the main branch.
