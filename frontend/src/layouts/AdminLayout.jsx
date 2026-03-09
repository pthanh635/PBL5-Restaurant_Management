import React from 'react';
import Header from '../components/Header';
import Sidebar from '../components/Sidebar';

export default function AdminLayout({ children }) {
	return (
		<div className="app-root">
			<Header />
			<div className="main-row">
				<Sidebar />
				<main className="main-content">{children}</main>
			</div>
		</div>
	);
}

