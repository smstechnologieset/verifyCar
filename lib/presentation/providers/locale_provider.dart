import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Default to Amharic — primary audience for this app.
final localeProvider = StateProvider<Locale>((ref) => const Locale('am'));
