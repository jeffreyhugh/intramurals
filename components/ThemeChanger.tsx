import { useTheme } from 'next-themes';
import { useEffect, useState } from 'react';
import { TbMoon, TbSun } from 'react-icons/tb';

import clsxm from '@/lib/clsxm';

type ThemeChangerProps = React.ComponentPropsWithoutRef<'label'>;

export default function ThemeChanger(props: ThemeChangerProps) {
  const [isMounted, setIsMounted] = useState(false);
  const { theme, setTheme } = useTheme();

  useEffect(() => {
    setIsMounted(true);
  }, []);

  return (
    <label
      className={clsxm(
        'swap btn btn-ghost swap-rotate btn-square px-6',
        props.className,
        isMounted ? 'visible' : 'invisible'
      )}
    >
      <input
        type='checkbox'
        onChange={() => setTheme(theme === 'light' ? 'dark' : 'light')}
        checked={theme !== 'light'}
      />
      <TbSun className='swap-on h-5 w-5' />
      <TbMoon className='swap-off h-5 w-5' />
    </label>
  );
}
