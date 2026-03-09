import React from 'react';

export default function Dashboard() {
	return (
		<div className="page">
			<h2>Dashboard</h2>
			<p>Chào mừng đến trang quản trị.</p>
			<div className="cards">
				<div className="card">Tổng đơn: 0</div>
				<div className="card">Doanh thu hôm nay: 0</div>
				<div className="card">Số món: 0</div>
			</div>
		</div>
	);
}

