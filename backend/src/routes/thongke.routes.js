/**
 * Thống Kê Routes - Reports & Analytics
 * Lấy các báo cáo, thống kê về doanh thu, số lượng, v.v
 */

const express = require('express');
const router = express.Router();
const thongkeController = require('../controllers/thongke.controller');
const authMiddleware = require('../middlewares/auth.middleware');
const roleMiddleware = require('../middlewares/role.middleware');

/**
 * Protected routes - Admin only
 */

// Lấy tổng quan dashboard
router.get('/dashboard', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getDashboard
);

// Doanh thu hàng ngày
// Query: { days }
router.get('/revenue/daily', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getDailyRevenue
);

// Doanh thu hàng tuần
// Query: { weeks }
router.get('/revenue/weekly', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getWeeklyRevenue
);

// Doanh thu hàng tháng
// Query: { months }
router.get('/revenue/monthly', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getMonthlyRevenue
);

// Món ăn bán chạy nhất
// Query: { limit }
router.get('/dishes/top', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getTopDishes
);

// Khách hàng VIP
// Query: { limit }
router.get('/customers/top', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getTopCustomers
);

// Báo cáo lợi nhuận
// Query: { fromDate, toDate }
router.get('/profit', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getProfitReport
);

// Báo cáo kho hàng
// Query: { status }
router.get('/inventory', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getInventoryReport
);

// Hiệu suất nhân viên
// Query: { fromDate, toDate }
router.get('/staff-performance', 
  authMiddleware, 
  roleMiddleware(['admin', 'nhanvien']), 
  thongkeController.getStaffPerformance
);

module.exports = router;
