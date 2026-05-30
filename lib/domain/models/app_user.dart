class AppUser {
  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    required this.isActive,
    this.createdAt,
  });

  final String uid;
  final String email;
  final String displayName;
  final String role;
  final bool isActive;
  final DateTime? createdAt;

  bool get isAdmin => role == 'admin' && isActive;
}
