import axiosClient from './axiosClient';

const unwrap = (res) => (res && res.data && res.data.data) ? res.data.data : res.data;

const hoadonApi = {
	create: (payload) => axiosClient.post('/hoadon', payload).then(unwrap),
	getById: (id) => axiosClient.get(`/hoadon/${id}`).then(unwrap),
	list: (params) => axiosClient.get('/hoadon', { params }).then(unwrap)
};

export default hoadonApi;

