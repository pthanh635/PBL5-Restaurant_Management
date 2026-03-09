import React, { useEffect, useState } from 'react';
import khoApi from '../../api/kho.api';

export default function KhoList() {
	const [items, setItems] = useState([]);

	useEffect(() => {
		(async () => {
			try {
				const data = await khoApi.getInventory();
				setItems(data || []);
			} catch (err) {
				console.error(err);
			}
		})();
	}, []);

	return (
		<div className="page">
			<h2>Kho hàng</h2>
			<table className="table">
				<thead>
					<tr><th>Tên nguyên liệu</th><th>Số lượng</th></tr>
				</thead>
				<tbody>
					{items.map(i => (
						<tr key={i.ID_NguyenLieu || i.id}>
							<td>{i.TenNguyenLieu || i.name}</td>
							<td>{i.SoLuong}</td>
						</tr>
					))}
				</tbody>
			</table>
		</div>
	);
}

