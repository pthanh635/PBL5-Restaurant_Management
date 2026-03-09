import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import monanApi from '../../api/monan.api';

export default function MonAnForm() {
	const { id } = useParams();
	const navigate = useNavigate();
	const [model, setModel] = useState({ TenMonAn: '', DonGia: '' });

	useEffect(() => {
		if (id && id !== 'new') {
			(async () => {
				const data = await monanApi.getById(id);
				setModel(data || {});
			})();
		}
	}, [id]);

	async function handleSubmit(e) {
		e.preventDefault();
		if (id && id !== 'new') {
			await monanApi.update(id, model);
		} else {
			await monanApi.create(model);
		}
		navigate('/monan');
	}

	return (
		<div className="page">
			<h2>{id && id !== 'new' ? 'Sửa món' : 'Thêm món'}</h2>
			<form className="card form" onSubmit={handleSubmit}>
				<label>Tên món</label>
				<input value={model.TenMonAn || ''} onChange={e => setModel({ ...model, TenMonAn: e.target.value })} />
				<label>Giá</label>
				<input type="number" value={model.DonGia || ''} onChange={e => setModel({ ...model, DonGia: e.target.value })} />
				<button className="btn" type="submit">Lưu</button>
			</form>
		</div>
	);
}

