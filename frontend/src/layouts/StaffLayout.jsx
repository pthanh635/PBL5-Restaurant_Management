import React from 'react';
import Header from '../components/Header';

export default function StaffLayout({ children }) {
	return (
		<div className="app-root">
			<Header />
			<div className="main-row staff">
				<main className="main-content">{children}</main>
			</div>
		</div>
	);
}

