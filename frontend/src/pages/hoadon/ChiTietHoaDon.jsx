import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import hoadonApi from '../../api/hoadon.api';

export default function ChiTietHoaDon() {
	const { id } = useParams();
	const [data, setData] = useState(null);

	useEffect(() => {
		if (!id) return;
		(async () => {
			try {
				const d = await hoadonApi.getById(id);
				setData(d);
			} catch (err) {
				console.error(err);
			}
		})();
	}, [id]);

	if (!data) return <div className="page">Đang tải chi tiết hóa đơn...</div>;

	return (
		<div className="page">
			<h2>Chi tiết Hóa đơn #{id}</h2>
			<pre>{JSON.stringify(data, null, 2)}</pre>
		</div>
	);
}

