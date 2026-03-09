import axiosClient from './axiosClient';

const unwrap = (res) => (res && res.data && res.data.data) ? res.data.data : res.data;

const khoApi = {
	getInventory: () => axiosClient.get('/kho').then(unwrap)
};

export default khoApi;

