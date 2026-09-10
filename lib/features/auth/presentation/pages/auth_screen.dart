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
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

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
        title: Text(GeniusLinkLocalization.of(context).signIn),
        automaticallyImplyLeading: false,        actions: const [
          AppLanguageToggleButton(),
          AppThemeToggleButton(),
        ],
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
                GeniusLinkLocalization.of(context).accessYourWorkspace,
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
              TInput(
                label: GeniusLinkLocalization.of(context).email,
                placeholder: 'you@company.com',
                defaultValue: 'layla.a@geniuslink.sa',
              ),
              const SizedBox(height: 16),
              TPassword(label: GeniusLinkLocalization.of(context).password, placeholder: '••••••••••'),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.go('/forgot'),
                  child: Text(
                    GeniusLinkLocalization.of(context).forgotPassword,
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
                GeniusLinkLocalization.of(context).signInToGeniusLink,
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
                        GeniusLinkLocalization.of(context).sessionsAreRecordedInTheAuditLogWithTimestampAndDevice,
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
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).createAccount), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
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
                GeniusLinkLocalization.of(context).provisionAWorkspace,
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
                GeniusLinkLocalization.of(context).youLlBeTheWorkspaceAdministrator,
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 13,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
              const SizedBox(height: 24),
              TInput(
                label: GeniusLinkLocalization.of(context).fullName,
                placeholder: GeniusLinkLocalization.of(context).eGKhalidAlRashid,
                required: true,
              ),
              const SizedBox(height: 16),
              TInput(
                label: GeniusLinkLocalization.of(context).workEmail,
                placeholder: 'you@company.com',
                required: true,
              ),
              const SizedBox(height: 16),
              TInput(
                label: GeniusLinkLocalization.of(context).organization,
                placeholder: GeniusLinkLocalization.of(context).eGAlRashidTradingCo,
                required: true,
              ),
              const SizedBox(height: 16),
              TPassword(label: GeniusLinkLocalization.of(context).password, required: true),
              const SizedBox(height: 16),
              TCheckbox(
                label:
                    GeniusLinkLocalization.of(context).iAgreeToTheTermsOfServiceAndDataProcessingAgreement,
                defaultChecked: true,
              ),
              const SizedBox(height: 16),
              MBtn(
                GeniusLinkLocalization.of(context).createWorkspace,
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
        appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).forgotPassword2), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
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
                    GeniusLinkLocalization.of(context).forgotPassword,
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
                    GeniusLinkLocalization.of(context).enterTheEmailTiedToYourAccount,
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
                    GeniusLinkLocalization.of(context).sendResetLink,
                    full: true,
                    onTap: _controller.sendResetLink,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        GeniusLinkLocalization.of(context).backToSignIn,
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
                          GeniusLinkLocalization.of(context).checkYourInbox,
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
                          GeniusLinkLocalization.of(context).useADifferentEmail,
                          variant: MBtnVariant.secondary,
                          full: true,
                          onTap: _controller.useDifferentEmail,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: Text(
                            GeniusLinkLocalization.of(context).backToSignIn,
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
