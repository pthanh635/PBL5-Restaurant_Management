import axiosClient from './axiosClient';

const unwrap = (res) => (res && res.data && res.data.data) ? res.data.data : res.data;

const monanApi = {
	getAll: (params) => axiosClient.get('/monan', { params }).then(unwrap),
	getById: (id) => axiosClient.get(`/monan/${id}`).then(unwrap),
	create: (payload) => axiosClient.post('/monan', payload).then(unwrap),
	update: (id, payload) => axiosClient.put(`/monan/${id}`, payload).then(unwrap),
	remove: (id) => axiosClient.delete(`/monan/${id}`).then(unwrap)
};

export default monanApi;

