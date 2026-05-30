import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';

import 'package:ethiodrive_history/core/theme/app_colors.dart';

import 'package:ethiodrive_history/domain/models/dashboard_stats.dart';

import 'package:ethiodrive_history/domain/models/vehicle.dart';

import 'package:ethiodrive_history/presentation/admin/dashboard/tabs/settings_tab.dart';

import 'package:ethiodrive_history/presentation/admin/dashboard/tabs/vehicles_tab.dart';

import 'package:ethiodrive_history/presentation/admin/dashboard/vehicle_form_sheet.dart';

import 'package:ethiodrive_history/presentation/providers/app_providers.dart';

import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';

import 'package:ethiodrive_history/presentation/shared/widgets/stat_card.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';



enum _AdminTab { vehicles, settings }



class AdminDashboardScreen extends ConsumerStatefulWidget {

  const AdminDashboardScreen({super.key});



  @override

  ConsumerState<AdminDashboardScreen> createState() =>

      _AdminDashboardScreenState();

}



class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {

  _AdminTab _tab = _AdminTab.vehicles;

  final _searchController = TextEditingController();



  @override

  void dispose() {

    _searchController.dispose();

    super.dispose();

  }



  Future<void> _logout() async {

    await ref.read(authRepositoryProvider).signOut();

    if (mounted) context.go('/admin');

  }



  void _openVehicleForm({Vehicle? vehicle}) {

    showModalBottomSheet<void>(

      context: context,

      isScrollControlled: true,

      backgroundColor: AppColors.surface,

      shape: const RoundedRectangleBorder(

        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),

      ),

      builder: (ctx) => VehicleFormSheet(vehicle: vehicle),

    );

  }



  @override

  Widget build(BuildContext context) {

    final l10n = context.l10n;

    final statsAsync = ref.watch(dashboardStatsProvider);

    final adminUserAsync = ref.watch(currentAppUserProvider);

    final currency = NumberFormat.currency(symbol: '', decimalDigits: 0);

    final adminEmail =

        adminUserAsync.valueOrNull?.displayName ??

        adminUserAsync.valueOrNull?.email ??

        'Administrator';

    final stats = statsAsync.valueOrNull ?? const DashboardStats();

    final statsLoading = statsAsync.isLoading && statsAsync.valueOrNull == null;

    final placeholder = l10n.dashPlaceholder;



    return Scaffold(

      backgroundColor: AppColors.surfaceElevated,

      appBar: AppBar(

        automaticallyImplyLeading: false,

        title: Column(

          children: [

            Text(

              l10n.federalRegistry,

              style: GoogleFonts.inter(

                fontSize: 13,

                fontWeight: FontWeight.w700,

                letterSpacing: 0.5,

              ),

            ),

            Text(

              l10n.adminControlCenter,

              style: GoogleFonts.inter(

                fontSize: 11,

                color: AppColors.textMuted,

              ),

            ),

          ],

        ),

        actions: [

          TextButton(

            onPressed: () => context.go('/'),

            child: Text(l10n.customerApp),

          ),

          IconButton(

            icon: const Icon(Icons.logout),

            onPressed: _logout,

            tooltip: l10n.logout,

          ),

        ],

      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),

            child: Row(

              children: [

                CircleAvatar(

                  backgroundColor: AppColors.surfaceElevated,

                  child: Text(

                    adminEmail.isNotEmpty

                        ? adminEmail[0].toUpperCase()

                        : 'A',

                    style: const TextStyle(color: AppColors.primaryOrange),

                  ),

                ),

                const SizedBox(width: 12),

                Expanded(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(

                        adminEmail.split('@').first.toUpperCase(),

                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),

                      ),

                      Container(

                        margin: const EdgeInsets.only(top: 4),

                        padding: const EdgeInsets.symmetric(

                          horizontal: 8,

                          vertical: 2,

                        ),

                        decoration: BoxDecoration(

                          color: AppColors.primaryOrange.withValues(alpha: 0.15),

                          borderRadius: BorderRadius.circular(4),

                        ),

                        child: Text(

                          l10n.adminBadge,

                          style: GoogleFonts.jetBrainsMono(

                            fontSize: 9,

                            color: AppColors.primaryOrange,

                            letterSpacing: 1,

                          ),

                        ),

                      ),

                    ],

                  ),

                ),

              ],

            ),

          ),

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: statsAsync.hasError

                ? Container(

                    width: double.infinity,

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(

                      color: AppColors.warningSurface,

                      borderRadius: BorderRadius.circular(12),

                      border: Border.all(color: AppColors.border),

                    ),

                    child: Text(

                      l10n.statsLoadError,

                      style: GoogleFonts.inter(

                        fontSize: 12,

                        color: AppColors.textSecondary,

                      ),

                    ),

                  )

                : GridView.count(

                    crossAxisCount: 2,

                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    mainAxisSpacing: 10,

                    crossAxisSpacing: 10,

                    childAspectRatio: 1.45,

                    children: [

                      StatCard(

                        label: l10n.totalVehicles,

                        value: statsLoading

                            ? placeholder

                            : '${stats.totalVehicles}',

                        icon: Icons.directions_car,

                      ),

                      StatCard(

                        label: l10n.totalSearches,

                        value: statsLoading

                            ? placeholder

                            : '${stats.totalSearches}',

                        icon: Icons.insights,

                      ),

                      StatCard(

                        label: l10n.reportsPaid,

                        value: statsLoading

                            ? placeholder

                            : '${stats.totalPaidReports}',

                        icon: Icons.lock_open,

                      ),

                      StatCard(

                        label: l10n.totalRevenue,

                        value: statsLoading

                            ? placeholder

                            : '${currency.format(stats.totalRevenueEtb)} ETB',

                        icon: Icons.trending_up,

                        valueColor: AppColors.accentTeal,

                      ),

                    ],

                  ),

          ),

          const SizedBox(height: 12),

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Row(

              children: [

                _TabChip(

                  label: l10n.tabVehicles,

                  icon: Icons.directions_car,

                  selected: _tab == _AdminTab.vehicles,

                  onTap: () => setState(() => _tab = _AdminTab.vehicles),

                ),

                const SizedBox(width: 8),

                _TabChip(

                  label: l10n.tabSettings,

                  icon: Icons.settings,

                  selected: _tab == _AdminTab.settings,

                  onTap: () => setState(() => _tab = _AdminTab.settings),

                ),

              ],

            ),

          ),

          const SizedBox(height: 8),

          Expanded(

            child: _tab == _AdminTab.vehicles

                ? VehiclesTab(

                    searchController: _searchController,

                    onAdd: () => _openVehicleForm(),

                    onEdit: (v) => _openVehicleForm(vehicle: v),

                  )

                : const SettingsTab(),

          ),

        ],

      ),

      floatingActionButton: _tab == _AdminTab.vehicles

          ? FloatingActionButton.extended(

              onPressed: () => _openVehicleForm(),

              backgroundColor: AppColors.accentTeal,

              icon: const Icon(Icons.add),

              label: Text(l10n.addVehicle),

            )

          : null,

    );

  }

}



class _TabChip extends StatelessWidget {

  const _TabChip({

    required this.label,

    required this.icon,

    required this.selected,

    required this.onTap,

  });



  final String label;

  final IconData icon;

  final bool selected;

  final VoidCallback onTap;



  @override

  Widget build(BuildContext context) {

    return Expanded(

      child: Material(

        color: selected ? AppColors.accentTeal.withValues(alpha: 0.15) : AppColors.surface,

        borderRadius: BorderRadius.circular(10),

        child: InkWell(

          onTap: onTap,

          borderRadius: BorderRadius.circular(10),

          child: Container(

            padding: const EdgeInsets.symmetric(vertical: 12),

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              border: Border.all(

                color: selected ? AppColors.accentTeal : AppColors.border,

              ),

            ),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Icon(

                  icon,

                  size: 18,

                  color: selected ? AppColors.accentTeal : AppColors.textMuted,

                ),

                const SizedBox(width: 8),

                Text(

                  label,

                  style: GoogleFonts.inter(

                    fontWeight: FontWeight.w600,

                    color: selected

                        ? AppColors.accentTeal

                        : AppColors.textMuted,

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}


