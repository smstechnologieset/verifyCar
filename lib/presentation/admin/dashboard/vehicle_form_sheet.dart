import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';

import 'package:ethiodrive_history/core/theme/app_colors.dart';

import 'package:ethiodrive_history/domain/models/vehicle.dart';

import 'package:ethiodrive_history/l10n/app_localizations.dart';

import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';



class VehicleFormSheet extends ConsumerStatefulWidget {

  const VehicleFormSheet({super.key, this.vehicle});



  final Vehicle? vehicle;



  @override

  ConsumerState<VehicleFormSheet> createState() => _VehicleFormSheetState();

}



class _VehicleFormSheetState extends ConsumerState<VehicleFormSheet> {

  final _formKey = GlobalKey<FormState>();

  late final Map<String, TextEditingController> _controllers;

  DateTime _licenseDate = DateTime.now();

  bool _blockedByBankForSale = false;

  bool _isSaving = false;



  bool get _isEditing => widget.vehicle != null;



  @override

  void initState() {

    super.initState();

    final v = widget.vehicle;

    _controllers = {

      'ownerName': TextEditingController(text: v?.ownerName ?? ''),

      'gender': TextEditingController(text: v?.gender ?? ''),

      'nationality': TextEditingController(text: v?.nationality ?? 'Ethiopian'),

      'region': TextEditingController(text: v?.region ?? ''),

      'city': TextEditingController(text: v?.city ?? ''),

      'subCity': TextEditingController(text: v?.subCity ?? ''),

      'kebele': TextEditingController(text: v?.kebele ?? ''),

      'houseNumber': TextEditingController(text: v?.houseNumber ?? ''),

      'phoneNumber': TextEditingController(text: v?.phoneNumber ?? ''),

      'licenseNumber': TextEditingController(text: v?.licenseNumber ?? ''),

      'previousLicenseNumber':

          TextEditingController(text: v?.previousLicenseNumber ?? ''),

      'vehicleType': TextEditingController(text: v?.vehicleType ?? ''),

      'makeCountry': TextEditingController(text: v?.makeCountry ?? ''),

      'model': TextEditingController(text: v?.model ?? ''),

      'year': TextEditingController(

        text: v != null ? '${v.manufacturingYear}' : '',

      ),

      'chassisNumber': TextEditingController(text: v?.chassisNumber ?? ''),

      'motorNumber': TextEditingController(text: v?.motorNumber ?? ''),

      'color': TextEditingController(text: v?.color ?? ''),

      'fuelType': TextEditingController(text: v?.fuelType ?? ''),

      'horsePower': TextEditingController(text: v?.horsePower ?? ''),

      'weightCarryingCapacity':

          TextEditingController(text: v?.weightCarryingCapacity ?? ''),

      'vehicleWeightWithoutCargo':

          TextEditingController(text: v?.vehicleWeightWithoutCargo ?? ''),

      'passengerCapacity': TextEditingController(

        text: v != null ? '${v.passengerCapacity}' : '',

      ),

      'motorCc': TextEditingController(text: v != null ? '${v.motorCc}' : ''),

      'cylinderCount':

          TextEditingController(text: v != null ? '${v.cylinderCount}' : ''),

      'authorizedServiceType':

          TextEditingController(text: v?.authorizedServiceType ?? ''),

      'axleCount':

          TextEditingController(text: v != null ? '${v.axleCount}' : ''),

    };

    if (v != null) {

      _licenseDate = v.licensePrintedDate;

      _blockedByBankForSale = v.blockedByBankForSale;

    }

  }



  @override

  void dispose() {

    for (final c in _controllers.values) {

      c.dispose();

    }

    super.dispose();

  }



  Future<void> _pickDate() async {

    final picked = await showDatePicker(

      context: context,

      initialDate: _licenseDate,

      firstDate: DateTime(1990),

      lastDate: DateTime.now(),

    );

    if (picked != null) setState(() => _licenseDate = picked);

  }



  Future<void> _save() async {

    if (!_formKey.currentState!.validate()) return;



    final l10n = context.l10n;

    final chassis = _controllers['chassisNumber']!.text.trim().toUpperCase();

    final repo = ref.read(vehicleRepositoryProvider);



    if (await repo.chassisExists(chassis, excludeId: widget.vehicle?.id)) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text(l10n.chassisMustBeUnique)),

      );

      return;

    }



    setState(() => _isSaving = true);



    final vehicle = Vehicle(

      id: widget.vehicle?.id ?? '',

      chassisNumber: chassis,

      ownerName: _controllers['ownerName']!.text.trim(),

      gender: _controllers['gender']!.text.trim(),

      nationality: _controllers['nationality']!.text.trim(),

      region: _controllers['region']!.text.trim(),

      city: _controllers['city']!.text.trim(),

      subCity: _controllers['subCity']!.text.trim(),

      kebele: _controllers['kebele']!.text.trim(),

      houseNumber: _controllers['houseNumber']!.text.trim(),

      phoneNumber: _controllers['phoneNumber']!.text.trim(),

      licenseNumber: _controllers['licenseNumber']!.text.trim(),

      previousLicenseNumber:

          _controllers['previousLicenseNumber']!.text.trim(),

      licensePrintedDate: _licenseDate,

      vehicleType: _controllers['vehicleType']!.text.trim(),

      makeCountry: _controllers['makeCountry']!.text.trim(),

      model: _controllers['model']!.text.trim(),

      manufacturingYear:

          int.parse(_controllers['year']!.text.trim()),

      motorNumber: _controllers['motorNumber']!.text.trim(),

      color: _controllers['color']!.text.trim(),

      fuelType: _controllers['fuelType']!.text.trim(),

      horsePower: _controllers['horsePower']!.text.trim(),

      weightCarryingCapacity:

          _controllers['weightCarryingCapacity']!.text.trim(),

      vehicleWeightWithoutCargo:

          _controllers['vehicleWeightWithoutCargo']!.text.trim(),

      passengerCapacity:

          int.parse(_controllers['passengerCapacity']!.text.trim()),

      motorCc: int.parse(_controllers['motorCc']!.text.trim()),

      cylinderCount: int.parse(_controllers['cylinderCount']!.text.trim()),

      authorizedServiceType:

          _controllers['authorizedServiceType']!.text.trim(),

      axleCount: int.parse(_controllers['axleCount']!.text.trim()),

      blockedByBankForSale: _blockedByBankForSale,

    );



    try {

      if (_isEditing) {

        await repo.updateVehicle(vehicle);

      } else {

        await repo.addVehicle(vehicle);

      }

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content:

              Text(_isEditing ? l10n.vehicleUpdated : l10n.vehicleRegistered),

        ),

      );

    } catch (e) {

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(content: Text(l10n.errorSaveFailed('$e'))),

        );

      }

    } finally {

      if (mounted) setState(() => _isSaving = false);

    }

  }



  String _fieldLabel(String key, AppLocalizations l10n) {

    switch (key) {

      case 'ownerName':

        return l10n.fieldName;

      case 'gender':

        return l10n.fieldGender;

      case 'nationality':

        return l10n.fieldNationality;

      case 'region':

        return l10n.fieldRegion;

      case 'city':

        return l10n.fieldCity;

      case 'subCity':

        return l10n.fieldSubCity;

      case 'kebele':

        return l10n.fieldKebele;

      case 'houseNumber':

        return l10n.fieldHouseNumber;

      case 'phoneNumber':

        return l10n.fieldPhoneNumber;

      case 'licenseNumber':

        return l10n.fieldLicenseNumber;

      case 'previousLicenseNumber':

        return l10n.fieldPreviousLicenseNumber;

      case 'vehicleType':

        return l10n.fieldVehicleType;

      case 'makeCountry':

        return l10n.fieldMakeCountry;

      case 'model':

        return l10n.fieldModel;

      case 'year':

        return l10n.fieldYear;

      case 'chassisNumber':

        return l10n.fieldChassisNumber;

      case 'motorNumber':

        return l10n.fieldMotorNumber;

      case 'color':

        return l10n.fieldColor;

      case 'fuelType':

        return l10n.fieldFuelType;

      case 'horsePower':

        return l10n.fieldHorsePower;

      case 'weightCarryingCapacity':

        return l10n.fieldWeightCarryingCapacity;

      case 'vehicleWeightWithoutCargo':

        return l10n.fieldWeightWithoutCargo;

      case 'passengerCapacity':

        return l10n.fieldPassengerCapacity;

      case 'motorCc':

        return l10n.fieldMotorCc;

      case 'cylinderCount':

        return l10n.fieldCylinderCount;

      case 'authorizedServiceType':

        return l10n.fieldAuthorizedServiceType;

      case 'axleCount':

        return l10n.fieldAxleCount;

      default:

        return key;

    }

  }



  @override

  Widget build(BuildContext context) {

    final l10n = context.l10n;

    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    final df = DateFormat('dd MMM yyyy');



    return Padding(

      padding: EdgeInsets.only(bottom: bottomInset),

      child: DraggableScrollableSheet(

        expand: false,

        initialChildSize: 0.92,

        minChildSize: 0.5,

        maxChildSize: 0.95,

        builder: (context, scrollController) {

          return Column(

            children: [

              const SizedBox(height: 8),

              Container(

                width: 40,

                height: 4,

                decoration: BoxDecoration(

                  color: AppColors.border,

                  borderRadius: BorderRadius.circular(2),

                ),

              ),

              Padding(

                padding: const EdgeInsets.all(20),

                child: Row(

                  children: [

                    Expanded(

                      child: Text(

                        _isEditing ? l10n.editVehicle : l10n.registerVehicle,

                        style: GoogleFonts.inter(

                          fontSize: 18,

                          fontWeight: FontWeight.w700,

                        ),

                      ),

                    ),

                    IconButton(

                      onPressed: () => Navigator.pop(context),

                      icon: const Icon(Icons.close),

                    ),

                  ],

                ),

              ),

              Expanded(

                child: Form(

                  key: _formKey,

                  child: ListView(

                    controller: scrollController,

                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),

                    children: [

                      _sectionTitle(l10n.ownerDetails),

                      ..._ownerFields(l10n),

                      const SizedBox(height: 8),

                      ListTile(

                        contentPadding: EdgeInsets.zero,

                        title: Text(

                          l10n.licensePrintedDate,

                          style: GoogleFonts.inter(fontSize: 13),

                        ),

                        subtitle: Text(df.format(_licenseDate)),

                        trailing: const Icon(Icons.calendar_today),

                        onTap: _pickDate,

                      ),

                      const SizedBox(height: 16),

                      _sectionTitle(l10n.vehicleDetails),

                      ..._vehicleFields(l10n),

                      const SizedBox(height: 8),

                      SwitchListTile(

                        contentPadding: EdgeInsets.zero,

                        title: Text(

                          l10n.blockedForSaleByBank,

                          style: GoogleFonts.inter(fontWeight: FontWeight.w500),

                        ),

                        subtitle: Text(

                          _blockedByBankForSale

                              ? l10n.blockedForSaleHintOn

                              : l10n.blockedForSaleHintOff,

                          style: GoogleFonts.inter(

                            fontSize: 12,

                            color: AppColors.textMuted,

                          ),

                        ),

                        value: _blockedByBankForSale,

                        activeThumbColor: AppColors.destructive,

                        activeTrackColor:

                            AppColors.destructive.withValues(alpha: 0.4),

                        onChanged: (value) =>

                            setState(() => _blockedByBankForSale = value),

                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(

                        onPressed: _isSaving ? null : _save,

                        child: _isSaving

                            ? const SizedBox(

                                width: 22,

                                height: 22,

                                child: CircularProgressIndicator(

                                  strokeWidth: 2,

                                  color: Colors.white,

                                ),

                              )

                            : Text(_isEditing ? l10n.saveChanges : l10n.register),

                      ),

                    ],

                  ),

                ),

              ),

            ],

          );

        },

      ),

    );

  }



  Widget _sectionTitle(String title) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 12, top: 8),

      child: Text(

        title.toUpperCase(),

        style: GoogleFonts.inter(

          fontSize: 12,

          fontWeight: FontWeight.w700,

          color: AppColors.accentTeal,

          letterSpacing: 0.5,

        ),

      ),

    );

  }



  List<Widget> _ownerFields(AppLocalizations l10n) {

    const fields = <({String key, bool required})>[

      (key: 'ownerName', required: true),

      (key: 'gender', required: true),

      (key: 'nationality', required: true),

      (key: 'region', required: true),

      (key: 'city', required: true),

      (key: 'subCity', required: true),

      (key: 'kebele', required: true),

      (key: 'houseNumber', required: true),

      (key: 'phoneNumber', required: true),

      (key: 'licenseNumber', required: true),

      (key: 'previousLicenseNumber', required: false),

    ];

    return fields

        .map(

          (f) => _field(

            f.key,

            _fieldLabel(f.key, l10n),

            l10n: l10n,

            required: f.required,

          ),

        )

        .toList();

  }



  List<Widget> _vehicleFields(AppLocalizations l10n) {

    const fields = <({String key, bool required, bool number})>[

      (key: 'vehicleType', required: true, number: false),

      (key: 'makeCountry', required: true, number: false),

      (key: 'model', required: true, number: false),

      (key: 'year', required: true, number: true),

      (key: 'chassisNumber', required: true, number: false),

      (key: 'motorNumber', required: true, number: false),

      (key: 'color', required: true, number: false),

      (key: 'fuelType', required: true, number: false),

      (key: 'horsePower', required: true, number: false),

      (key: 'weightCarryingCapacity', required: true, number: false),

      (key: 'vehicleWeightWithoutCargo', required: true, number: false),

      (key: 'passengerCapacity', required: true, number: true),

      (key: 'motorCc', required: true, number: true),

      (key: 'cylinderCount', required: true, number: true),

      (key: 'authorizedServiceType', required: true, number: false),

      (key: 'axleCount', required: true, number: true),

    ];

    return fields

        .map(

          (f) => _field(

            f.key,

            _fieldLabel(f.key, l10n),

            l10n: l10n,

            required: f.required,

            number: f.number,

          ),

        )

        .toList();

  }



  Widget _field(

    String key,

    String label, {

    required AppLocalizations l10n,

    bool required = true,

    bool number = false,

  }) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 12),

      child: TextFormField(

        controller: _controllers[key],

        keyboardType: number ? TextInputType.number : TextInputType.text,

        textCapitalization: key == 'chassisNumber'

            ? TextCapitalization.characters

            : TextCapitalization.none,

        decoration: InputDecoration(labelText: label),

        validator: required

            ? (v) {

                if (v == null || v.trim().isEmpty) return l10n.fieldRequired;

                if (number && int.tryParse(v.trim()) == null) {

                  return l10n.fieldInvalidNumber;

                }

                return null;

              }

            : null,

      ),

    );

  }

}


