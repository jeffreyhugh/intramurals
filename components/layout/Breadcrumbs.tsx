import Link from 'next/link';
import { useRouter } from 'next/router';
import { TbHome } from 'react-icons/tb';
import title from 'title';

export const Breadcrumbs = () => {
  const router = useRouter();

  const pathArgs = router.asPath
    .split('/')
    .splice(1)
    .map((arg) => arg.split('?')[0]) // remove query params
    .map((arg) => arg.split('#')[0]); // remove anchor

  const content = (v: string) =>
    isUUID(v) ? v.toLowerCase() : title(v.replaceAll('-', ' '));

  return (
    <div className='breadcrumbs'>
      <ul>
        {pathArgs[0] !== '' ? (
          <li>
            <Link href='/'>
              <TbHome className='translate-x-px opacity-50' />
            </Link>
          </li>
        ) : (
          <div className='h-4' />
        )}
        {pathArgs.map((v, i) => (
          <li
            key={i}
            className={i !== pathArgs.length - 1 ? 'opacity-50' : 'opacity-80'}
          >
            {i === pathArgs.length - 1 ? (
              content(v)
            ) : (
              <Link href={`/${pathArgs.slice(0, i + 1).join('/')}`}>
                {content(v)}
              </Link>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
};

const isUUID = (s: string) =>
  s.search(
    /^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$/i
  ) !== -1;
