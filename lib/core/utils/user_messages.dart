import 'package:ethiodrive_history/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract final class UserMessages {
  static String authError(FirebaseAuthException e, AppLocalizations l10n) {
    switch (e.code) {
      case 'invalid-email':
        return l10n.errorInvalidEmail;
      case 'user-disabled':
        return l10n.errorUserDisabled;
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'invalid-login-credentials':
        return l10n.errorWrongCredentials;
      case 'too-many-requests':
        return l10n.errorTooManyRequests;
      case 'network-request-failed':
        return l10n.errorNetwork;
      case 'permission-denied':
        return e.message ?? l10n.errorNotAdmin;
      default:
        return l10n.errorSignInFailed;
    }
  }

  static String fromError(Object error, AppLocalizations l10n) {
    if (error is FirebaseAuthException) {
      return authError(error, l10n);
    }
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return l10n.errorPermissionDenied;
        case 'unavailable':
        case 'deadline-exceeded':
          return l10n.errorRegistryUnavailable;
        default:
          return l10n.errorGeneric;
      }
    }
    return l10n.errorGeneric;
  }

  static String vehicleNotFound(AppLocalizations l10n) => l10n.errorVehicleNotFound;
}
