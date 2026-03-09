import React, { useState } from 'react';
import authApi from '../../api/auth.api';
import { useAuth } from '../../hooks/useAuth';
import { useNavigate } from 'react-router-dom';

export default function Login() {
	const { login } = useAuth();
	const navigate = useNavigate();
	const [email, setEmail] = useState('');
	const [password, setPassword] = useState('');
	const [error, setError] = useState(null);
	const [loading, setLoading] = useState(false);

	async function handleSubmit(e) {
		e.preventDefault();
		setError(null);
		setLoading(true);
		try {
			const data = await authApi.login({ Email: email, MatKhau: password });
			// backend returns { token, refreshToken, user } inside data
			const token = data.token || data.accessToken || data.token;
			const user = data.user || data;
			await login(token, user);
			// Navigate based on role
			const role = user?.VaiTro || user?.role;
			if (role === 'admin') navigate('/');
			else if (role === 'nhanvien') navigate('/hoadon/tao');
			else if (role === 'khachhang') navigate('/customer');
			else navigate('/');
			console.log('login success', { token, user });
		} catch (err) {
			console.error('login error', err);
			setError(err.response?.data?.message || 'Đăng nhập thất bại');
		} finally {
			setLoading(false);
		}
	}

	return (
		<div className="page login-page">
			<form className="card form" onSubmit={handleSubmit}>
				<h2>Đăng nhập</h2>
				{error && <div className="error">{error}</div>}
				<label>Email / Tên đăng nhập</label>
				<input value={email} onChange={e => setEmail(e.target.value)} />
				<label>Mật khẩu</label>
				<input type="password" value={password} onChange={e => setPassword(e.target.value)} />
				<button className="btn" type="submit" disabled={loading}>{loading ? 'Đang đăng nhập...' : 'Đăng nhập'}</button>
			</form>
		</div>
	);
}

