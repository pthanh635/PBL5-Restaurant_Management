import React from 'react';
import { useAuth } from '../hooks/useAuth';

export default function Header() {
	const { user, logout } = useAuth();

	return (
		<header className="app-header">
			<div className="brand">Quản lý Nhà hàng</div>
			<div className="header-right">
				{user && <span className="user">Xin chào, {user.TenNguoiDung || user.name || 'Người dùng'}</span>}
				<button className="btn small" onClick={logout}>Đăng xuất</button>
			</div>
		</header>
	);
}

