import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import monanApi from '../../api/monan.api';

export default function MonAnList() {
	const [list, setList] = useState([]);

	useEffect(() => {
		(async () => {
			try {
				const data = await monanApi.getAll();
				setList(data || []);
			} catch (err) {
				console.error(err);
			}
		})();
	}, []);

	return (
		<div className="page">
			<div className="page-header">
				<h2>Danh sách món ăn</h2>
				<Link to="/monan/new" className="btn">Thêm món</Link>
			</div>
			<table className="table">
				<thead>
					<tr><th>Tên</th><th>Giá</th><th>Trạng thái</th><th>Hành động</th></tr>
				</thead>
				<tbody>
					{list.map(m => (
						<tr key={m.ID_MonAn || m.id}>
							<td>{m.TenMonAn || m.name}</td>
							<td>{m.DonGia ? m.DonGia.toLocaleString() : '-'}</td>
							<td>{m.TrangThai}</td>
							<td>
								<Link to={`/monan/${m.ID_MonAn || m.id}`}>Sửa</Link>
							</td>
						</tr>
					))}
				</tbody>
			</table>
		</div>
	);
}

