import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';

import 'package:ethiodrive_history/core/theme/app_colors.dart';

import 'package:ethiodrive_history/domain/models/vehicle.dart';

import 'package:ethiodrive_history/l10n/app_localizations.dart';

import 'package:ethiodrive_history/presentation/providers/app_providers.dart';

import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';

import 'package:ethiodrive_history/presentation/shared/widgets/app_card.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';



class VehiclesTab extends ConsumerStatefulWidget {

  const VehiclesTab({

    super.key,

    required this.searchController,

    required this.onAdd,

    required this.onEdit,

  });



  final TextEditingController searchController;

  final VoidCallback onAdd;

  final void Function(Vehicle vehicle) onEdit;



  @override

  ConsumerState<VehiclesTab> createState() => _VehiclesTabState();

}



class _VehiclesTabState extends ConsumerState<VehiclesTab> {

  String _query = '';



  @override

  void initState() {

    super.initState();

    widget.searchController.addListener(_onSearchChanged);

  }



  @override

  void dispose() {

    widget.searchController.removeListener(_onSearchChanged);

    super.dispose();

  }



  void _onSearchChanged() {

    setState(() => _query = widget.searchController.text.trim().toLowerCase());

  }



  Future<void> _confirmDelete(Vehicle vehicle) async {

    final l10n = context.l10n;

    final confirmed = await showDialog<bool>(

      context: context,

      builder: (ctx) => AlertDialog(

        backgroundColor: AppColors.surface,

        title: Text(l10n.deleteVehicleTitle),

        content: Text(

          l10n.deleteVehicleBody(vehicle.model, vehicle.chassisNumber),

        ),

        actions: [

          TextButton(

            onPressed: () => Navigator.pop(ctx, false),

            child: Text(l10n.cancel),

          ),

          TextButton(

            onPressed: () => Navigator.pop(ctx, true),

            style: TextButton.styleFrom(foregroundColor: AppColors.destructive),

            child: Text(l10n.delete),

          ),

        ],

      ),

    );

    if (confirmed == true) {

      try {

        await ref.read(vehicleRepositoryProvider).deleteVehicle(vehicle.id);

      } catch (e) {

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(content: Text(l10n.errorDeleteFailed('$e'))),

        );

      }

    }

  }



  @override

  Widget build(BuildContext context) {

    final l10n = context.l10n;

    final vehiclesAsync = ref.watch(vehiclesStreamProvider);



    return vehiclesAsync.when(

      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Center(child: Text(l10n.errorLoadVehicles('$e'))),

      data: (vehicles) {

    final filtered = _query.isEmpty

        ? vehicles

        : vehicles.where((v) {

            return v.chassisNumber.toLowerCase().contains(_query) ||

                v.model.toLowerCase().contains(_query) ||

                v.ownerName.toLowerCase().contains(_query);

          }).toList();



    return Column(

      children: [

        Padding(

          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),

          child: TextField(

            controller: widget.searchController,

            decoration: InputDecoration(

              hintText: l10n.searchVehiclesHint,

              prefixIcon: const Icon(Icons.search),

            ),

          ),

        ),

        Padding(

          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Text(

                l10n.registryRecords,

                style: GoogleFonts.inter(

                  fontSize: 12,

                  fontWeight: FontWeight.w700,

                  letterSpacing: 0.5,

                ),

              ),

              Text(

                l10n.recordCount(filtered.length),

                style: GoogleFonts.inter(

                  fontSize: 12,

                  color: AppColors.textMuted,

                ),

              ),

            ],

          ),

        ),

        const SizedBox(height: 8),

        Expanded(

          child: filtered.isEmpty

              ? _EmptyState(onAdd: widget.onAdd, l10n: l10n)

              : ListView.builder(

                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),

                  itemCount: filtered.length,

                  itemBuilder: (context, index) {

                    final v = filtered[index];

                    return Padding(

                      padding: const EdgeInsets.only(bottom: 10),

                      child: AppCard(

                        padding: const EdgeInsets.all(16),

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Row(

                              children: [

                                Expanded(

                                  child: Text(

                                    v.model,

                                    style: GoogleFonts.inter(

                                      fontWeight: FontWeight.w700,

                                      fontSize: 16,

                                    ),

                                  ),

                                ),

                                Container(

                                  padding: const EdgeInsets.symmetric(

                                    horizontal: 8,

                                    vertical: 4,

                                  ),

                                  decoration: BoxDecoration(

                                    color: AppColors.surfaceElevated,

                                    borderRadius: BorderRadius.circular(6),

                                  ),

                                  child: Text(

                                    v.color,

                                    style: GoogleFonts.inter(fontSize: 12),

                                  ),

                                ),

                              ],

                            ),

                            const SizedBox(height: 4),

                            Text(

                              v.chassisNumber,

                              style: GoogleFonts.jetBrainsMono(

                                fontSize: 12,

                                color: AppColors.textMuted,

                              ),

                            ),

                            const SizedBox(height: 4),

                            Text(

                              v.ownerName,

                              style: GoogleFonts.inter(

                                fontSize: 13,

                                color: AppColors.textSecondary,

                              ),

                            ),

                            const SizedBox(height: 8),

                            Container(

                              padding: const EdgeInsets.symmetric(

                                horizontal: 8,

                                vertical: 4,

                              ),

                              decoration: BoxDecoration(

                                color: (v.blockedByBankForSale

                                        ? AppColors.destructive

                                        : AppColors.accentTeal)

                                    .withValues(alpha: 0.12),

                                borderRadius: BorderRadius.circular(6),

                                border: Border.all(

                                  color: (v.blockedByBankForSale

                                          ? AppColors.destructive

                                          : AppColors.accentTeal)

                                      .withValues(alpha: 0.35),

                                ),

                              ),

                              child: Text(

                                v.blockedByBankForSale

                                    ? l10n.blockedShort

                                    : l10n.notBlockedShort,

                                style: GoogleFonts.inter(

                                  fontSize: 11,

                                  fontWeight: FontWeight.w600,

                                  color: v.blockedByBankForSale

                                      ? AppColors.destructive

                                      : AppColors.accentTeal,

                                ),

                              ),

                            ),

                            const SizedBox(height: 12),

                            Row(

                              children: [

                                TextButton.icon(

                                  onPressed: () => widget.onEdit(v),

                                  icon: const Icon(Icons.edit, size: 18),

                                  label: Text(l10n.edit),

                                ),

                                TextButton.icon(

                                  onPressed: () => _confirmDelete(v),

                                  icon: const Icon(

                                    Icons.delete_outline,

                                    size: 18,

                                    color: AppColors.destructive,

                                  ),

                                  label: Text(

                                    l10n.delete,

                                    style: const TextStyle(

                                      color: AppColors.destructive,

                                    ),

                                  ),

                                ),

                              ],

                            ),

                          ],

                        ),

                      ),

                    );

                  },

                ),

        ),

      ],

    );

      },

    );

  }

}



class _EmptyState extends StatelessWidget {

  const _EmptyState({required this.onAdd, required this.l10n});



  final VoidCallback onAdd;

  final AppLocalizations l10n;



  @override

  Widget build(BuildContext context) {

    return Center(

      child: Padding(

        padding: const EdgeInsets.all(32),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(

              Icons.directions_car_outlined,

              size: 64,

              color: AppColors.textMuted.withValues(alpha: 0.4),

            ),

            const SizedBox(height: 16),

            Text(

              l10n.noVehiclesTitle,

              style: GoogleFonts.inter(

                fontWeight: FontWeight.w600,

                fontSize: 16,

              ),

            ),

            const SizedBox(height: 8),

            Text(

              l10n.noVehiclesSubtitle,

              textAlign: TextAlign.center,

              style: GoogleFonts.inter(color: AppColors.textMuted),

            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(

              onPressed: onAdd,

              icon: const Icon(Icons.add),

              label: Text(l10n.addNewVehicle),

              style: ElevatedButton.styleFrom(

                backgroundColor: AppColors.accentTeal,

              ),

            ),

          ],

        ),

      ),

    );

  }

}


