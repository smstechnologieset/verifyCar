import 'package:ethiodrive_history/presentation/admin/dashboard/admin_dashboard_screen.dart';
import 'package:ethiodrive_history/presentation/admin/login/admin_login_screen.dart';
import 'package:ethiodrive_history/presentation/customer/home/home_screen.dart';
import 'package:ethiodrive_history/presentation/customer/payment/payment_screen.dart';
import 'package:ethiodrive_history/presentation/customer/preview/vehicle_preview_screen.dart';
import 'package:ethiodrive_history/presentation/customer/report/vehicle_report_screen.dart';
import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';
import 'package:ethiodrive_history/presentation/shell/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/admin',
            redirect: (context, state) async {
              final user =
                  await ref.read(authRepositoryProvider).getCurrentAppUser();
              if (user != null) return '/admin/dashboard';
              return null;
            },
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AdminLoginScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/preview/:chassis',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final chassis = Uri.decodeComponent(state.pathParameters['chassis']!);
          return VehiclePreviewScreen(chassisNumber: chassis);
        },
      ),
      GoRoute(
        path: '/payment/:chassis',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final chassis = Uri.decodeComponent(state.pathParameters['chassis']!);
          return PaymentScreen(chassisNumber: chassis);
        },
      ),
      GoRoute(
        path: '/report/:chassis',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final chassis = Uri.decodeComponent(state.pathParameters['chassis']!);
          final paymentRef = state.uri.queryParameters['ref'];
          return VehicleReportScreen(
            chassisNumber: chassis,
            paymentReference: paymentRef,
          );
        },
      ),
      GoRoute(
        path: '/admin/dashboard',
        parentNavigatorKey: _rootNavigatorKey,
        redirect: (context, state) async {
          final user =
              await ref.read(authRepositoryProvider).getCurrentAppUser();
          if (user == null) return '/admin';
          return null;
        },
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );
});
