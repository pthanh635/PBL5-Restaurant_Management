-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th1 28, 2026 lúc 03:31 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `QuanLyNhaHang`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Ban`
--

CREATE TABLE `Ban` (
  `ID_Ban` int(11) NOT NULL,
  `TenBan` varchar(50) NOT NULL COMMENT 'Tên bàn: Bàn 1, Bàn A, etc.',
  `SoChoNgoi` int(11) DEFAULT NULL COMMENT 'Số lượng chỗ ngồi',
  `ViTri` varchar(50) DEFAULT NULL COMMENT 'Vị trí bàn trong nhà hàng',
  `TrangThai` varchar(30) DEFAULT 'trong' COMMENT 'trong | dang_su_dung | da_dat'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng bàn ăn - quản lý các bàn trong nhà hàng';

--
-- Đang đổ dữ liệu cho bảng `Ban`
--

INSERT INTO `Ban` (`ID_Ban`, `TenBan`, `SoChoNgoi`, `ViTri`, `TrangThai`) VALUES
(1, 'Ban 1', 2, 'Goc cua so', 'trong'),
(2, 'Ban 2', 4, 'Giua phong', 'trong'),
(3, 'Ban 3', 6, 'Pho thong', 'trong'),
(4, 'Bàn 5', 6, 'Sảnh chờ', 'trong'),
(5, 'Bàn 7', 4, 'Ban Công', 'trong');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `CTHD`
--

CREATE TABLE `CTHD` (
  `ID_HoaDon` int(11) NOT NULL COMMENT 'Foreign key tới HoaDon',
  `ID_MonAn` int(11) NOT NULL COMMENT 'Foreign key tới MonAn',
  `SoLuong` int(11) NOT NULL DEFAULT 1 COMMENT 'Số lượng món ăn',
  `DonGia` decimal(10,0) NOT NULL COMMENT 'Giá tại thời điểm bán (có thể khác giá hiện tại)',
  `ThanhTien` decimal(12,0) NOT NULL COMMENT 'Thành tiền = SoLuong * DonGia',
  `GhiChu` varchar(255) DEFAULT NULL COMMENT 'Ghi chú đặc biệt: không đường, ít muối, etc.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chi tiết hóa đơn - danh sách món ăn trong hóa đơn';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `CTNhap`
--

CREATE TABLE `CTNhap` (
  `ID_NK` int(11) NOT NULL COMMENT 'Foreign key tới PhieuNhap',
  `ID_NL` int(11) NOT NULL COMMENT 'Foreign key tới NguyenLieu',
  `SoLuong` int(11) NOT NULL COMMENT 'Số lượng nhập',
  `DonGia` decimal(10,0) NOT NULL COMMENT 'Giá nhập tại thời điểm nhập',
  `ThanhTien` decimal(12,0) NOT NULL COMMENT 'Thành tiền = SoLuong * DonGia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chi tiết phiếu nhập - danh sách nguyên liệu trong phiếu nhập';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `CTXuat`
--

CREATE TABLE `CTXuat` (
  `ID_XK` int(11) NOT NULL COMMENT 'Foreign key tới PhieuXuat',
  `ID_NL` int(11) NOT NULL COMMENT 'Foreign key tới NguyenLieu',
  `SoLuong` int(11) NOT NULL COMMENT 'Số lượng xuất'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chi tiết phiếu xuất - danh sách nguyên liệu trong phiếu xuất';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `DanhMuc`
--

CREATE TABLE `DanhMuc` (
  `ID_DanhMuc` int(11) NOT NULL,
  `TenDanhMuc` varchar(100) NOT NULL COMMENT 'Tên danh mục: Cơm, Nước, etc.',
  `MoTa` varchar(255) DEFAULT NULL COMMENT 'Mô tả danh mục'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng danh mục món ăn';

--
-- Đang đổ dữ liệu cho bảng `DanhMuc`
--

INSERT INTO `DanhMuc` (`ID_DanhMuc`, `TenDanhMuc`, `MoTa`) VALUES
(1, 'Com', NULL),
(2, 'Canh', NULL),
(3, 'Nuoc Uong', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `HoaDon`
--

CREATE TABLE `HoaDon` (
  `ID_HoaDon` int(11) NOT NULL,
  `ID_KH` int(11) DEFAULT NULL COMMENT 'Foreign key tới KhachHang (optional nếu khách vãng lai)',
  `ID_NV` int(11) DEFAULT NULL COMMENT 'Foreign key tới NhanVien - nhân viên tạo hóa đơn',
  `ID_Ban` int(11) DEFAULT NULL COMMENT 'Foreign key tới Ban - bàn ăn',
  `NgayHD` datetime DEFAULT NULL COMMENT 'Ngày tạo hóa đơn',
  `TrangThai` varchar(30) DEFAULT 'dang_mo' COMMENT 'dang_mo | da_thanh_toan | da_huy',
  `TongTienMon` decimal(12,0) DEFAULT 0 COMMENT 'Tổng tiền các món ăn (không bao gồm thuế, giảm giá)',
  `VAT` decimal(10,0) DEFAULT 0 COMMENT 'Tiền VAT (thuế)',
  `TienGiam` decimal(10,0) DEFAULT 0 COMMENT 'Tiền giảm giá từ voucher',
  `TongThanhToan` decimal(12,0) DEFAULT 0 COMMENT 'Tổng thành toán = TongTienMon + VAT - TienGiam',
  `PhuongThucThanhToan` varchar(50) DEFAULT NULL COMMENT 'Phương thức thanh toán: tien_mat, card, etc.',
  `CodeVoucher` varchar(20) DEFAULT NULL COMMENT 'Foreign key tới Voucher',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng hóa đơn - lưu thông tin giao dịch';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `KhachHang`
--

CREATE TABLE `KhachHang` (
  `ID_KH` int(11) NOT NULL,
  `ID_ND` int(11) NOT NULL COMMENT 'Foreign key tới NguoiDung',
  `NgayThamGia` date DEFAULT NULL COMMENT 'Ngày khách hàng tham gia hệ thống',
  `ChiTieu` decimal(12,0) DEFAULT 0 COMMENT 'Tổng chi tiêu của khách hàng',
  `DiemTichLuy` int(11) DEFAULT 0 COMMENT 'Điểm tích lũy để đổi voucher'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng khách hàng - mở rộng thông tin từ NguoiDung';

--
-- Đang đổ dữ liệu cho bảng `KhachHang`
--

INSERT INTO `KhachHang` (`ID_KH`, `ID_ND`, `NgayThamGia`, `ChiTieu`, `DiemTichLuy`) VALUES
(1, 4, '2026-01-26', 500000, 100),
(2, 5, '2026-01-26', 250000, 50);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Kho`
--

CREATE TABLE `Kho` (
  `ID_NL` int(11) NOT NULL COMMENT 'Foreign key tới NguyenLieu',
  `SLTon` int(11) NOT NULL DEFAULT 0 COMMENT 'Số lượng tồn kho'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng kho - quản lý số lượng tồn kho của mỗi nguyên liệu';

--
-- Đang đổ dữ liệu cho bảng `Kho`
--

INSERT INTO `Kho` (`ID_NL`, `SLTon`) VALUES
(1, 50),
(2, 30),
(3, 20);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `MonAn`
--

CREATE TABLE `MonAn` (
  `ID_MonAn` int(11) NOT NULL,
  `TenMonAn` varchar(100) NOT NULL COMMENT 'Tên món ăn',
  `DonGia` decimal(10,2) NOT NULL COMMENT 'Giá bán của món ăn',
  `MoTa` varchar(255) DEFAULT NULL COMMENT 'Mô tả chi tiết về món ăn',
  `ID_DanhMuc` int(11) NOT NULL COMMENT 'Foreign key tới DanhMuc',
  `TrangThai` varchar(30) DEFAULT 'available' COMMENT 'available | unavailable',
  `HinhAnh` varchar(255) DEFAULT NULL COMMENT 'URL hoặc path tới ảnh món ăn'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng món ăn - danh sách các món trong menu';

--
-- Đang đổ dữ liệu cho bảng `MonAn`
--

INSERT INTO `MonAn` (`ID_MonAn`, `TenMonAn`, `DonGia`, `MoTa`, `ID_DanhMuc`, `TrangThai`, `HinhAnh`) VALUES
(1, 'Com Chien', 35000.00, 'Com chien trieu chau', 1, 'available', NULL),
(2, 'Com Pho', 45000.00, 'Com pho thom ngon', 1, 'available', NULL),
(3, 'Canh Chua', 25000.00, 'Canh chua ca', 2, 'available', NULL),
(4, 'Nuoc Chanh', 8000.00, 'Nuoc chanh mat lanh', 3, 'available', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `NguoiDung`
--

CREATE TABLE `NguoiDung` (
  `ID_ND` int(11) NOT NULL,
  `Ten` varchar(100) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `VerifyCode` varchar(10) DEFAULT NULL,
  `TrangThai` varchar(20) DEFAULT 'active' COMMENT 'active | inactive | pending_verify',
  `VaiTro` enum('admin','nhanvien','khachhang') NOT NULL DEFAULT 'khachhang' COMMENT 'Vai trò của người dùng trong hệ thống'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng người dùng - base user model cho toàn hệ thống';

--
-- Đang đổ dữ liệu cho bảng `NguoiDung`
--

INSERT INTO `NguoiDung` (`ID_ND`, `Ten`, `Email`, `MatKhau`, `VerifyCode`, `TrangThai`, `VaiTro`) VALUES
(1, 'Admin', 'admin@restaurant.com', '$2b$10$/x4P3MFr/pLLRVrZouLd9ONkOQkkl69DT7yMe4ZwjtOizjDpU841e', NULL, 'active', 'admin'),
(2, 'Nguyen Van A', 'staff1@restaurant.com', '$2b$10$Aqv7KPJ42EQYivSHgdvq1evZV6Iod5DrQp2FwYvjXcCZ7rZiRSWfu', NULL, 'active', 'nhanvien'),
(3, 'Tran Thi B', 'staff2@restaurant.com', '$2b$10$wPgNe3plQm4YAT2GXUIDyutFHqqyxbl0DzPR6qdkl9GjztKtz5YLa', NULL, 'active', 'nhanvien'),
(4, 'Khach Hang 1', 'customer1@email.com', '$2b$10$UZ0BydbikXKpwbEZM.sAWenusdUaLWJkXAEbxb3.XuVfWIZrgbjRS', NULL, 'active', 'khachhang'),
(5, 'Khach Hang 2', 'customer2@email.com', '$2b$10$QzPeOj2n2r7jKIGBRoBcBu4DD93W5TGWAeGnDmENqVxLrnUZggHsm', NULL, 'active', 'khachhang');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `NguyenLieu`
--

CREATE TABLE `NguyenLieu` (
  `ID_NL` int(11) NOT NULL,
  `TenNL` varchar(100) NOT NULL COMMENT 'Tên nguyên liệu: Gạo, Cà chua, etc.',
  `DonGia` decimal(10,2) NOT NULL COMMENT 'Giá mua nguyên liệu',
  `DonViTinh` varchar(50) NOT NULL COMMENT 'Đơn vị tính: kg, lít, cái, bộ, etc.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng nguyên liệu - danh sách các nguyên liệu trong kho';

--
-- Đang đổ dữ liệu cho bảng `NguyenLieu`
--

INSERT INTO `NguyenLieu` (`ID_NL`, `TenNL`, `DonGia`, `DonViTinh`) VALUES
(1, 'Gao Trang', 2000.00, 'kg'),
(2, 'Thit Heo', 50000.00, 'kg'),
(3, 'Ca Thanh', 80000.00, 'kg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `NhanVien`
--

CREATE TABLE `NhanVien` (
  `ID_NV` int(11) NOT NULL,
  `ID_ND` int(11) NOT NULL COMMENT 'Foreign key tới NguoiDung',
  `NgayVaoLam` date DEFAULT NULL COMMENT 'Ngày vào làm của nhân viên',
  `SDT` varchar(20) DEFAULT NULL COMMENT 'Số điện thoại liên hệ',
  `ChucVu` varchar(50) DEFAULT NULL COMMENT 'Chức vụ: phục vụ, bếp, quản lý, etc.',
  `TinhTrang` varchar(30) DEFAULT 'dang_lam' COMMENT 'dang_lam | nghi | da_nghỉ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng nhân viên - mở rộng thông tin từ NguoiDung';

--
-- Đang đổ dữ liệu cho bảng `NhanVien`
--

INSERT INTO `NhanVien` (`ID_NV`, `ID_ND`, `NgayVaoLam`, `SDT`, `ChucVu`, `TinhTrang`) VALUES
(1, 2, NULL, '0912345678', 'Thu Ngan', 'dang_lam'),
(2, 3, NULL, '0987654321', 'Phuc Vu', 'dang_lam');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `PhieuNhap`
--

CREATE TABLE `PhieuNhap` (
  `ID_NK` int(11) NOT NULL,
  `ID_NV` int(11) NOT NULL COMMENT 'Foreign key tới NhanVien - nhân viên tạo phiếu nhập',
  `NgayNhap` date NOT NULL COMMENT 'Ngày nhập hàng',
  `TongTien` decimal(12,0) NOT NULL DEFAULT 0 COMMENT 'Tổng tiền nhập = tổng của (SoLuong * DonGia) trong CTNhap'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Phiếu nhập hàng - lưu thông tin nhập kho';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `PhieuXuat`
--

CREATE TABLE `PhieuXuat` (
  `ID_XK` int(11) NOT NULL,
  `ID_NV` int(11) NOT NULL COMMENT 'Foreign key tới NhanVien - nhân viên tạo phiếu xuất',
  `NgayXuat` date NOT NULL COMMENT 'Ngày xuất hàng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Phiếu xuất hàng - lưu thông tin xuất kho';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Voucher`
--

CREATE TABLE `Voucher` (
  `CodeVoucher` varchar(20) NOT NULL COMMENT 'Code voucher duy nhất',
  `MoTa` varchar(255) DEFAULT NULL COMMENT 'Mô tả chi tiết về voucher',
  `PhanTramGiam` int(11) DEFAULT NULL COMMENT 'Phần trăm giảm giá (0-100)',
  `SoLuong` int(11) DEFAULT 0 COMMENT 'Số lượng voucher còn lại',
  `DiemDoi` int(11) DEFAULT 0 COMMENT 'Số điểm tích lũy cần để đổi voucher này'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng voucher - mã giảm giá';

--
-- Đang đổ dữ liệu cho bảng `Voucher`
--

INSERT INTO `Voucher` (`CodeVoucher`, `MoTa`, `PhanTramGiam`, `SoLuong`, `DiemDoi`) VALUES
('GIAM10', NULL, 10, 100, 500),
('GIAM20', NULL, 20, 50, 1000);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `Ban`
--
ALTER TABLE `Ban`
  ADD PRIMARY KEY (`ID_Ban`);

--
-- Chỉ mục cho bảng `CTHD`
--
ALTER TABLE `CTHD`
  ADD PRIMARY KEY (`ID_HoaDon`,`ID_MonAn`),
  ADD KEY `ID_MonAn` (`ID_MonAn`);

--
-- Chỉ mục cho bảng `CTNhap`
--
ALTER TABLE `CTNhap`
  ADD PRIMARY KEY (`ID_NK`,`ID_NL`),
  ADD KEY `ID_NL` (`ID_NL`);

--
-- Chỉ mục cho bảng `CTXuat`
--
ALTER TABLE `CTXuat`
  ADD PRIMARY KEY (`ID_XK`,`ID_NL`),
  ADD KEY `ID_NL` (`ID_NL`);

--
-- Chỉ mục cho bảng `DanhMuc`
--
ALTER TABLE `DanhMuc`
  ADD PRIMARY KEY (`ID_DanhMuc`),
  ADD UNIQUE KEY `tendanhmuc_unique` (`TenDanhMuc`);

--
-- Chỉ mục cho bảng `HoaDon`
--
ALTER TABLE `HoaDon`
  ADD PRIMARY KEY (`ID_HoaDon`),
  ADD KEY `ID_KH` (`ID_KH`),
  ADD KEY `ID_NV` (`ID_NV`),
  ADD KEY `ID_Ban` (`ID_Ban`),
  ADD KEY `CodeVoucher` (`CodeVoucher`);

--
-- Chỉ mục cho bảng `KhachHang`
--
ALTER TABLE `KhachHang`
  ADD PRIMARY KEY (`ID_KH`),
  ADD UNIQUE KEY `id_nd_unique` (`ID_ND`);

--
-- Chỉ mục cho bảng `Kho`
--
ALTER TABLE `Kho`
  ADD PRIMARY KEY (`ID_NL`);

--
-- Chỉ mục cho bảng `MonAn`
--
ALTER TABLE `MonAn`
  ADD PRIMARY KEY (`ID_MonAn`),
  ADD KEY `ID_DanhMuc` (`ID_DanhMuc`);

--
-- Chỉ mục cho bảng `NguoiDung`
--
ALTER TABLE `NguoiDung`
  ADD PRIMARY KEY (`ID_ND`),
  ADD UNIQUE KEY `email_unique` (`Email`);

--
-- Chỉ mục cho bảng `NguyenLieu`
--
ALTER TABLE `NguyenLieu`
  ADD PRIMARY KEY (`ID_NL`),
  ADD UNIQUE KEY `tennl_unique` (`TenNL`);

--
-- Chỉ mục cho bảng `NhanVien`
--
ALTER TABLE `NhanVien`
  ADD PRIMARY KEY (`ID_NV`),
  ADD UNIQUE KEY `id_nd_unique` (`ID_ND`);

--
-- Chỉ mục cho bảng `PhieuNhap`
--
ALTER TABLE `PhieuNhap`
  ADD PRIMARY KEY (`ID_NK`),
  ADD KEY `ID_NV` (`ID_NV`);

--
-- Chỉ mục cho bảng `PhieuXuat`
--
ALTER TABLE `PhieuXuat`
  ADD PRIMARY KEY (`ID_XK`),
  ADD KEY `ID_NV` (`ID_NV`);

--
-- Chỉ mục cho bảng `Voucher`
--
ALTER TABLE `Voucher`
  ADD PRIMARY KEY (`CodeVoucher`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `Ban`
--
ALTER TABLE `Ban`
  MODIFY `ID_Ban` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `DanhMuc`
--
ALTER TABLE `DanhMuc`
  MODIFY `ID_DanhMuc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `HoaDon`
--
ALTER TABLE `HoaDon`
  MODIFY `ID_HoaDon` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `KhachHang`
--
ALTER TABLE `KhachHang`
  MODIFY `ID_KH` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `MonAn`
--
ALTER TABLE `MonAn`
  MODIFY `ID_MonAn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `NguoiDung`
--
ALTER TABLE `NguoiDung`
  MODIFY `ID_ND` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `NguyenLieu`
--
ALTER TABLE `NguyenLieu`
  MODIFY `ID_NL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `NhanVien`
--
ALTER TABLE `NhanVien`
  MODIFY `ID_NV` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `PhieuNhap`
--
ALTER TABLE `PhieuNhap`
  MODIFY `ID_NK` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `PhieuXuat`
--
ALTER TABLE `PhieuXuat`
  MODIFY `ID_XK` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `CTHD`
--
ALTER TABLE `CTHD`
  ADD CONSTRAINT `cthd_ibfk_1` FOREIGN KEY (`ID_HoaDon`) REFERENCES `HoaDon` (`ID_HoaDon`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cthd_ibfk_2` FOREIGN KEY (`ID_MonAn`) REFERENCES `MonAn` (`ID_MonAn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `CTNhap`
--
ALTER TABLE `CTNhap`
  ADD CONSTRAINT `ctnhap_ibfk_1` FOREIGN KEY (`ID_NK`) REFERENCES `PhieuNhap` (`ID_NK`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ctnhap_ibfk_2` FOREIGN KEY (`ID_NL`) REFERENCES `NguyenLieu` (`ID_NL`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `CTXuat`
--
ALTER TABLE `CTXuat`
  ADD CONSTRAINT `ctxuat_ibfk_1` FOREIGN KEY (`ID_XK`) REFERENCES `PhieuXuat` (`ID_XK`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ctxuat_ibfk_2` FOREIGN KEY (`ID_NL`) REFERENCES `NguyenLieu` (`ID_NL`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `HoaDon`
--
ALTER TABLE `HoaDon`
  ADD CONSTRAINT `hoadon_ibfk_29` FOREIGN KEY (`ID_KH`) REFERENCES `KhachHang` (`ID_KH`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hoadon_ibfk_30` FOREIGN KEY (`ID_NV`) REFERENCES `NhanVien` (`ID_NV`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hoadon_ibfk_31` FOREIGN KEY (`ID_Ban`) REFERENCES `Ban` (`ID_Ban`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hoadon_ibfk_32` FOREIGN KEY (`CodeVoucher`) REFERENCES `Voucher` (`CodeVoucher`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `KhachHang`
--
ALTER TABLE `KhachHang`
  ADD CONSTRAINT `khachhang_ibfk_1` FOREIGN KEY (`ID_ND`) REFERENCES `NguoiDung` (`ID_ND`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `Kho`
--
ALTER TABLE `Kho`
  ADD CONSTRAINT `kho_ibfk_1` FOREIGN KEY (`ID_NL`) REFERENCES `NguyenLieu` (`ID_NL`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `MonAn`
--
ALTER TABLE `MonAn`
  ADD CONSTRAINT `monan_ibfk_1` FOREIGN KEY (`ID_DanhMuc`) REFERENCES `DanhMuc` (`ID_DanhMuc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `NhanVien`
--
ALTER TABLE `NhanVien`
  ADD CONSTRAINT `nhanvien_ibfk_1` FOREIGN KEY (`ID_ND`) REFERENCES `NguoiDung` (`ID_ND`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `PhieuNhap`
--
ALTER TABLE `PhieuNhap`
  ADD CONSTRAINT `phieunhap_ibfk_1` FOREIGN KEY (`ID_NV`) REFERENCES `NhanVien` (`ID_NV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `PhieuXuat`
--
ALTER TABLE `PhieuXuat`
  ADD CONSTRAINT `phieuxuat_ibfk_1` FOREIGN KEY (`ID_NV`) REFERENCES `NhanVien` (`ID_NV`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
