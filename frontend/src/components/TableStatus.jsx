import React from 'react';

export default function TableStatus({ status }) {
	const map = {
		trong: 'green',
		dang_su_dung: 'red',
		da_dat: 'orange'
	};
	const color = map[status] || 'gray';
	return (
		<span className={`status status-${color}`}>{status}</span>
	);
}

