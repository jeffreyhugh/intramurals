import Link from 'next/link';

export default function Footer() {
  return (
    <footer className='footer footer-center absolute bottom-0 border-t border-t-neutral/10 bg-dark-100 p-4 text-light-100'>
      <div>
        <p>
          &copy; {new Date().getFullYear()}{' '}
          <Link className='link' href='https://intramurals.net'>
            Intramurals.net
          </Link>
        </p>
      </div>
    </footer>
  );
}
