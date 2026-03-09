import React from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Login from '../pages/auth/Login';
import Dashboard from '../pages/dashboard/Dashboard';
import MonAnList from '../pages/monan/MonAnList';
import MonAnForm from '../pages/monan/MonAnForm';
import BanList from '../pages/ban/BanList';
import KhoList from '../pages/kho/KhoList';
import TaoHoaDon from '../pages/hoadon/TaoHoaDon';
import ChiTietHoaDon from '../pages/hoadon/ChiTietHoaDon';
import AdminLayout from '../layouts/AdminLayout';
import StaffLayout from '../layouts/StaffLayout';
import CustomerLayout from '../layouts/CustomerLayout';
import { useAuth } from '../hooks/useAuth';
import CustomerHome from '../pages/customer/CustomerHome';

function PrivateRoute({ children, roles }) {
	const { token: ctxToken, user: ctxUser } = useAuth();
	// fallback to localStorage to avoid race when login sets context then navigates
	const token = ctxToken || localStorage.getItem('token');
	const storedUser = (() => {
		try { return JSON.parse(localStorage.getItem('user') || 'null'); } catch { return null; }
	})();
	const user = ctxUser || storedUser;

	if (!token) return <Navigate to="/login" replace />;

	// If roles specified, ensure user has one of the allowed roles
	if (roles && roles.length > 0) {
		const role = user?.VaiTro || user?.role;
		if (!role || !roles.includes(role)) {
			// Redirect unauthorized users to a role-appropriate landing page
			const fallback = role === 'khachhang' ? '/customer' : role === 'nhanvien' ? '/hoadon/tao' : '/login';
			return <Navigate to={fallback} replace />;
		}
	}

	return children;
}

export default function AppRoutes() {
	return (
		<BrowserRouter>
			<Routes>
				<Route path="/login" element={<Login />} />
				<Route path="/" element={<PrivateRoute roles={[ 'admin' ]}><AdminLayout><Dashboard /></AdminLayout></PrivateRoute>} />
				<Route path="/monan" element={<PrivateRoute roles={[ 'admin' ]}><AdminLayout><MonAnList /></AdminLayout></PrivateRoute>} />
				<Route path="/monan/:id" element={<PrivateRoute roles={[ 'admin' ]}><AdminLayout><MonAnForm /></AdminLayout></PrivateRoute>} />
				<Route path="/ban" element={<PrivateRoute roles={[ 'nhanvien','admin' ]}><StaffLayout><BanList /></StaffLayout></PrivateRoute>} />
				<Route path="/kho" element={<PrivateRoute roles={[ 'admin' ]}><AdminLayout><KhoList /></AdminLayout></PrivateRoute>} />
				<Route path="/hoadon/tao" element={<PrivateRoute roles={[ 'nhanvien','admin' ]}><StaffLayout><TaoHoaDon /></StaffLayout></PrivateRoute>} />
				<Route path="/hoadon/:id" element={<PrivateRoute roles={[ 'nhanvien','admin' ]}><StaffLayout><ChiTietHoaDon /></StaffLayout></PrivateRoute>} />
				<Route path="/customer" element={<PrivateRoute roles={[ 'khachhang' ]}><CustomerLayout><CustomerHome /></CustomerLayout></PrivateRoute>} />
			</Routes>
		</BrowserRouter>
	);
}

