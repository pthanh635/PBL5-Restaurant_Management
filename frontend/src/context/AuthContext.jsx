import React, { createContext, useEffect, useState } from 'react';
import authApi from '../api/auth.api';

const AuthContext = createContext();

export function AuthProvider({ children }) {
	const [token, setToken] = useState(() => localStorage.getItem('token'));
	const [user, setUser] = useState(() => {
		try { return JSON.parse(localStorage.getItem('user') || 'null'); } catch { return null; }
	});

	useEffect(() => {
		if (token && !user) {
			(async () => {
				try {
					const me = await authApi.me();
					setUser(me);
					localStorage.setItem('user', JSON.stringify(me));
				} catch (err) {
					console.error('Failed to fetch user', err);
				}
			})();
		}
	}, [token, user]);

	const login = async (tkn, u) => {
		setToken(tkn);
		localStorage.setItem('token', tkn);
		if (u) {
			setUser(u);
			localStorage.setItem('user', JSON.stringify(u));
		}
	};

	const logout = () => {
		setToken(null);
		setUser(null);
		localStorage.removeItem('token');
		localStorage.removeItem('user');
	};

	return (
		<AuthContext.Provider value={{ token, user, login, logout }}>
			{children}
		</AuthContext.Provider>
	);
}

export default AuthContext;

