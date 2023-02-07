import { ReactNode } from 'react';

import clsxm from '@/lib/clsxm';

import SyntaxHighlightedCode from '@/components/layout/SyntaxHighlightedCode';

const Code = ({
  children,
  className,
  ...rest
}: {
  children?: ReactNode;
  className?: string;
}) =>
  /\s?language-[A-Za-z0-9]+/.test(className || '') ? (
    <CodeBlock className={className} {...rest}>
      {children}
    </CodeBlock>
  ) : (
    <InlineCode className={className} {...rest}>
      {children}
    </InlineCode>
  );

const InlineCode = ({
  children,
  className,
  ...rest
}: {
  children?: ReactNode;
  className?: string;
}) => (
  <span className={clsxm('font-mono', className)} {...rest}>
    <code>
      <span className='-ml-2 select-none no-underline'>`</span>
      {children}
      <span className='-mr-2 select-none no-underline'>`</span>
    </code>
  </span>
);

const CodeBlock = ({
  children,
  className,
  ...rest
}: {
  children?: ReactNode;
  className?: string;
}) => {
  const r = /\s?language-([A-Za-z0-9]+)/gi;
  const matches = className?.match(r);
  const language = (matches && matches[0].split('-')[1]) || '';

  return (
    <div {...rest}>
      <SyntaxHighlightedCode language={language}>
        {children}
      </SyntaxHighlightedCode>
    </div>
  );
};

export default Code;
