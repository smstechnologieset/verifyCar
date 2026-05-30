class DashboardStats {
  const DashboardStats({
    this.totalVehicles = 0,
    this.totalSearches = 0,
    this.totalPaidReports = 0,
    this.totalRevenueEtb = 0,
  });

  final int totalVehicles;
  final int totalSearches;
  final int totalPaidReports;
  final double totalRevenueEtb;

  DashboardStats copyWith({
    int? totalVehicles,
    int? totalSearches,
    int? totalPaidReports,
    double? totalRevenueEtb,
  }) {
    return DashboardStats(
      totalVehicles: totalVehicles ?? this.totalVehicles,
      totalSearches: totalSearches ?? this.totalSearches,
      totalPaidReports: totalPaidReports ?? this.totalPaidReports,
      totalRevenueEtb: totalRevenueEtb ?? this.totalRevenueEtb,
    );
  }
}
