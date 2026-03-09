import React from 'react';
import Header from '../components/Header';

export default function CustomerLayout({ children }) {
  return (
    <div className="app-root">
      <Header />
      <div className="main-row customer">
        <main className="main-content">{children}</main>
      </div>
    </div>
  );
}
