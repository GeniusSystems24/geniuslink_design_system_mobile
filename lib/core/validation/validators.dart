class Validators {
  static String? required(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;
  static String? email(String? v) => (v != null && v.contains('@')) ? null : 'Invalid email';
}
