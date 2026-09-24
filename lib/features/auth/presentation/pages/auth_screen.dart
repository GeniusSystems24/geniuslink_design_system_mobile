import 'package:flutter/material.dart';

import 'package:gl_mobile_app/design_system/kit.dart';

import '../controllers/auth_controller.dart';
import '../widgets/widgets.dart';

// componentized-by: dismantle_admin_auth_banking_pages.py
/// Authentication page boundary for signing in.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// LoginScreen(controller: controller)
/// ```
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) => LoginView(controller: controller);
}

/// Authentication page boundary for workspace registration.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// SignUpScreen(controller: controller)
/// ```
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) => SignUpView(controller: controller);
}

/// Authentication page boundary for password-reset flow state.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const ForgotScreen()
/// ```
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  late final ForgotPasswordController _controller;
  final _email = SuperTextFieldController();

  @override
  void initState() {
    super.initState();
    _controller = ForgotPasswordController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordView(controller: _controller, emailController: _email);
  }
}
