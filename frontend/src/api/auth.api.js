import axiosClient from './axiosClient';

const unwrap = (res) => (res && res.data && res.data.data) ? res.data.data : res.data;

const authApi = {
	login: (payload) => axiosClient.post('/auth/login', payload).then(unwrap),
	me: () => axiosClient.get('/auth/me').then(unwrap),
	logout: () => Promise.resolve()
};

export default authApi;

