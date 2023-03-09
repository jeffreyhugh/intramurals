import { useTeamMemberships } from '@/lib/hooks/useTeamMemberships';

import Skeleton from '@/components/Skeleton';

export const MemberList = ({ teamID }: { teamID: string }) => {
  const membership = useTeamMemberships(teamID);
  const { data, isLoading, error } = membership;
  if (error) {
    //eslint-disable-next-line no-console
    console.error(error);
  }
  return (
    <div>
      {isLoading && (
        <div>
          <Skeleton className='h-8 w-full'></Skeleton>
        </div>
      )}
      {data && data.map((m) => <div key={m.user_id}>{m.user_id}</div>)}
    </div>
  );
};
