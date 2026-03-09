import React from 'react';
import { NavLink } from 'react-router-dom';

export default function Sidebar() {
	return (
		<aside className="sidebar">
			<nav>
				<ul>
					<li><NavLink to="/">Dashboard</NavLink></li>
					<li><NavLink to="/monan">Món ăn</NavLink></li>
					<li><NavLink to="/ban">Bàn</NavLink></li>
					<li><NavLink to="/kho">Kho</NavLink></li>
					<li><NavLink to="/hoadon/tao">Tạo Hóa Đơn</NavLink></li>
				</ul>
			</nav>
		</aside>
	);
}

