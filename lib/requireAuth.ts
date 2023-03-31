import { createServerSupabaseClient } from '@supabase/auth-helpers-nextjs';
import { GetServerSidePropsContext, GetServerSidePropsResult } from 'next';

import { Database } from '@/lib/types/database.types';

export const requireAuth = ({
  getServerSideProps,
}: {
  getServerSideProps?: (
    ctx: GetServerSidePropsContext
  ) => GetServerSidePropsResult<unknown>;
}) => {
  return async function f(ctx: GetServerSidePropsContext) {
    const client = await createServerSupabaseClient<Database>(ctx);

    const {
      data: { session },
    } = await client.auth.getSession();

    if (!session) {
      return {
        redirect: {
          destination: `/signin${
            ctx.req.url ? `?redirectTo=${encodeURIComponent(ctx.req.url)}` : ''
          }`,
          permanent: false,
        },
      };
    }

    if (getServerSideProps) {
      return await getServerSideProps(ctx);
    }

    return {
      props: {},
    };
  };
};
