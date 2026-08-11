// ============================================================
// VIEW — Auth screens: Login · SignUp · Forgot Password
// (ports MLogin, MSignUp, MForgot)
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async' show unawaited;

import 'package:flutter/gestures.dart';
import '../../../../design_system/kit.dart';
import '../controllers/auth_controller.dart';

class _Brand extends StatelessWidget {
  const _Brand();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: SuperMaterialThemeData.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: Text(
          'G',
          style: TextStyle(
            fontFamily: SuperMaterialThemeData.of(
              context,
            ).textTheme.headlineMedium?.fontFamily,
            fontWeight: FontWeight.w800,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'GeniusLink',
        style: TextStyle(
          fontFamily: SuperMaterialThemeData.of(
            context,
          ).textTheme.headlineMedium?.fontFamily,
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: SuperMaterialThemeData.of(context).superTheme.fg1,
          letterSpacing: -0.2,
        ),
      ),
    ],
  );
}

Widget _authEyebrow(BuildContext context, String text) => Text(
  text.toUpperCase(),
  style: TextStyle(
    fontFamily: SuperMaterialThemeData.of(
      context,
    ).textTheme.bodyMedium?.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    letterSpacing: 1.6,
    color: SuperMaterialThemeData.of(context).colorScheme.primary,
  ),
);

class LoginScreen extends StatelessWidget {
  final AuthController controller;
  const LoginScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: const Text('Sign In'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 48, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Brand(),
              const SizedBox(height: 40),
              _authEyebrow(context, 'Sign In'),
              const SizedBox(height: 14),
              Text(
                'Access your workspace',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.headlineMedium?.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  height: 1.25,
                  letterSpacing: -0.7,
                  color: SuperMaterialThemeData.of(context).superTheme.fg1,
                ),
              ),
              const SizedBox(height: 28),
              const TInput(
                label: 'Email',
                placeholder: 'you@company.com',
                defaultValue: 'layla.a@geniuslink.sa',
              ),
              const SizedBox(height: 16),
              const TPassword(label: 'Password', placeholder: '••••••••••'),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.go('/forgot'),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MBtn(
                'Sign In to GeniusLink',
                full: true,
                onTap: () =>
                    unawaited(controller.login('layla.a@geniuslink.sa', '')),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'New organization?  ',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 12.5,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg3,
                        ),
                      ),
                      TextSpan(
                        text: 'Create a workspace',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 12.5,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: _tap(() => context.go('/signup')),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: SuperMaterialThemeData.of(context).superTheme.inputBg,
                  border: Border.all(
                    color: SuperMaterialThemeData.of(context).superTheme.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 14,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.primary,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'Sessions are recorded in the audit log with timestamp and device.',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 11.5,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg3,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final AuthController controller;
  const SignUpScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 44, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Brand(),
              const SizedBox(height: 32),
              _authEyebrow(context, 'Create Account'),
              const SizedBox(height: 12),
              Text(
                'Provision a workspace',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.headlineMedium?.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  height: 1.25,
                  letterSpacing: -0.65,
                  color: SuperMaterialThemeData.of(context).superTheme.fg1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You'll be the workspace administrator.",
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 13,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
              const SizedBox(height: 24),
              const TInput(
                label: 'Full Name',
                placeholder: 'e.g. Khalid Al-Rashid',
                required: true,
              ),
              const SizedBox(height: 16),
              const TInput(
                label: 'Work Email',
                placeholder: 'you@company.com',
                required: true,
              ),
              const SizedBox(height: 16),
              const TInput(
                label: 'Organization',
                placeholder: 'e.g. Al-Rashid Trading Co.',
                required: true,
              ),
              const SizedBox(height: 16),
              const TPassword(label: 'Password', required: true),
              const SizedBox(height: 16),
              const TCheckbox(
                label:
                    'I agree to the Terms of Service and Data Processing Agreement.',
                defaultChecked: true,
              ),
              const SizedBox(height: 16),
              MBtn(
                'Create Workspace',
                full: true,
                onTap: () => unawaited(
                  controller.signUp('owner@new-co.example', 'New Workspace'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account?  ',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 13,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg3,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 13,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: _tap(() => context.go('/login')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => Scaffold(
        backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
        appBar: SuperAppBar(title: const Text('Forgot Password')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 44, 28, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Brand(),
                const SizedBox(height: 40),
                if (!_controller.sent) ...[
                  _authEyebrow(context, 'Password Reset'),
                  const SizedBox(height: 12),
                  Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.headlineMedium?.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      height: 1.25,
                      letterSpacing: -0.65,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the email tied to your account.',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 13,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SuperTextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: 'you@company.com',
                      prefixIcon: Icon(Icons.email_outlined, size: 18),
                    ),
                    type: SuperTextType.email,
                    clearable: true,
                  ),
                  const SizedBox(height: 16),
                  MBtn(
                    'Send Reset Link',
                    full: true,
                    onTap: _controller.sendResetLink,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        'Back to sign in',
                        style: TextStyle(
                          fontSize: 13,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: superCoreTint(
                              SuperMaterialThemeData.of(
                                context,
                              ).colorScheme.secondary,
                              0x1F,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: superCoreTint(
                                SuperMaterialThemeData.of(
                                  context,
                                ).colorScheme.secondary,
                                0x66,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 24,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Check your inbox',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.headlineMedium?.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'A reset link was sent to\n',
                              ),
                              TextSpan(
                                text: _email.value.isEmpty
                                    ? 'you@company.com'
                                    : _email.value,
                                style: TextStyle(
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg1,
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                ),
                              ),
                              const TextSpan(
                                text: '. It expires in 30 minutes.',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 13,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 28),
                        MBtn(
                          'Use a different email',
                          variant: MBtnVariant.secondary,
                          full: true,
                          onTap: _controller.useDifferentEmail,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: Text(
                            'Back to sign in',
                            style: TextStyle(
                              fontSize: 13,
                              color: SuperMaterialThemeData.of(
                                context,
                              ).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// tiny tap-recognizer helper for inline links
TapGestureRecognizer _tap(VoidCallback onTap) =>
    TapGestureRecognizer()..onTap = onTap;
