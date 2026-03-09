export function formatCurrency(value) {
	if (value == null) return '-';
	return (Number(value)).toLocaleString('vi-VN') + ' đ';
}

export default { formatCurrency };

