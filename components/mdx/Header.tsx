import { ReactNode } from 'react';
import { TbLink } from 'react-icons/tb';

function getAnchor(child: ReactNode): string {
  if (Array.isArray(child)) {
    return child.map((c) => getAnchor(c)).join('');
  }
  if (!child) {
    return '';
  } else if (typeof child === 'object') {
    if ('props' in child) {
      if ('className' in child.props) {
        if (child.props.className.includes('katex')) {
          return getKatexAnchor(child.props.children);
        } else {
          return getAnchor(child.props.children);
        }
      }
      return getAnchor(child.props.children);
    } else {
      return '';
    }
  } else {
    return (
      child
        .toString()
        .toLowerCase()
        .replace(/[^a-z0-9\- ]/g, '')
        .replace(/[ ]/g, '-') || ''
    );
  }
}

// This is janky AF but it "works"
// Works in cases like `## Math with $\LaTeX$`
// Does not work in cases like `$3x = 6$`
// Due to oddities of how KaTeX renders stuff, if there are multiple sibling children, it can return an anchor like `katexkatexkatex`
// If we're dealing with a KaTeX child, just figure out the anchor for the first child and it's "good enough" (fails if there are multiple children in one block)
function getKatexAnchor(child: ReactNode): string {
  if (Array.isArray(child)) {
    return getKatexAnchor(child[0]);
  }
  if (!child) {
    return '';
  } else if (typeof child === 'object') {
    if ('props' in child) {
      return getKatexAnchor(child.props.children);
    } else {
      return '';
    }
  } else {
    return (
      child
        .toString()
        .toLowerCase()
        .replace(/[^a-z0-9 ]/g, '')
        .replace(/[ ]/g, '-') || ''
    );
  }
}

export const H1 = ({ children }: { children?: ReactNode }) => {
  const anchor = getAnchor(children);

  return (
    <h1 id={anchor} className='group relative scroll-mt-20'>
      <a
        href={`#${anchor}`}
        className='absolute bottom-1/4 hidden -translate-x-6 pr-2 text-lg text-inherit group-hover:inline'
      >
        <TbLink />
      </a>
      {children}
    </h1>
  );
};

export const H2 = ({ children }: { children?: ReactNode }) => {
  const anchor = getAnchor(children);

  return (
    <h2 id={anchor} className='group relative scroll-mt-20'>
      <a
        href={`#${anchor}`}
        className='absolute bottom-1/4 hidden -translate-x-6 pr-2 text-lg text-inherit group-hover:inline'
      >
        <TbLink />
      </a>
      {children}
    </h2>
  );
};

export const H3 = ({ children }: { children?: ReactNode }) => {
  const anchor = getAnchor(children);

  return (
    <h3 id={anchor} className='group relative'>
      <a
        href={`#${anchor}`}
        className='absolute bottom-1/4 hidden -translate-x-6 pr-2 text-lg group-hover:inline'
      >
        <TbLink />
      </a>
      {children}
    </h3>
  );
};

export const H4 = ({ children }: { children?: ReactNode }) => {
  const anchor = getAnchor(children);

  return (
    <h4 id={anchor} className='group relative'>
      <a
        href={`#${anchor}`}
        className='absolute bottom-1/4 hidden -translate-x-6 pr-2 text-lg group-hover:inline'
      >
        <TbLink />
      </a>
      {children}
    </h4>
  );
};
