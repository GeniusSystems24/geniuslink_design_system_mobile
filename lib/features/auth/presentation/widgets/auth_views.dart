import 'dart:async' show unawaited;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import '../controllers/auth_controller.dart';
import 'auth_components.dart';

/// Presentation view extracted from `LoginScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// LoginView(controller: controller)
/// ```
class LoginView extends StatelessWidget {
  final AuthController controller;
  const LoginView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AuthPageScaffold(
      title: Text(GeniusLinkLocalization.of(context).signIn),
      automaticallyImplyLeading: false,
      theme: AuthPageScaffoldThemeData(
        padding: const EdgeInsets.fromLTRB(28, 48, 28, 40),
      ),
      children: [
        SuperGrid(
          scope: SuperGridScope.current,
          children: [
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const AuthBrand(),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 40),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const AuthEyebrow(child: Text('SIGN IN')),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 14),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Text(
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
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 28),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: TInput(
                label: GeniusLinkLocalization.of(context).email,
                placeholder: 'you@company.com',
                defaultValue: 'layla.a@geniuslink.sa',
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: TPassword(
                label: GeniusLinkLocalization.of(context).password,
                placeholder: '••••••••••',
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Align(
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
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: MBtn(
                GeniusLinkLocalization.of(context).signInToGeniusLink,
                full: true,
                onTap: () =>
                    unawaited(controller.login('layla.a@geniuslink.sa', '')),
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Center(
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
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Container(
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
                        GeniusLinkLocalization.of(
                          context,
                        ).sessionsAreRecordedInTheAuditLogWithTimestampAndDevice,
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
            ),
          ],
        ),
      ],
    );
  }
}

/// Presentation view extracted from `SignUpScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// SignUpView(controller: controller)
/// ```
class SignUpView extends StatelessWidget {
  final AuthController controller;
  const SignUpView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AuthPageScaffold(
      title: Text(GeniusLinkLocalization.of(context).createAccount),
      automaticallyImplyLeading: true,
      theme: AuthPageScaffoldThemeData(
        padding: const EdgeInsets.fromLTRB(28, 44, 28, 40),
      ),
      children: [
        SuperGrid(
          scope: SuperGridScope.current,
          children: [
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const AuthBrand(),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 32),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const AuthEyebrow(child: Text('CREATE ACCOUNT')),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 12),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Text(
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
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 8),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Text(
                GeniusLinkLocalization.of(
                  context,
                ).youLlBeTheWorkspaceAdministrator,
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 13,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 24),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: TInput(
                label: GeniusLinkLocalization.of(context).fullName,
                placeholder: GeniusLinkLocalization.of(
                  context,
                ).eGKhalidAlRashid,
                required: true,
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: TInput(
                label: GeniusLinkLocalization.of(context).workEmail,
                placeholder: 'you@company.com',
                required: true,
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: TInput(
                label: GeniusLinkLocalization.of(context).organization,
                placeholder: GeniusLinkLocalization.of(
                  context,
                ).eGAlRashidTradingCo,
                required: true,
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: TPassword(
                label: GeniusLinkLocalization.of(context).password,
                required: true,
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: TCheckbox(
                label: GeniusLinkLocalization.of(
                  context,
                ).iAgreeToTheTermsOfServiceAndDataProcessingAgreement,
                defaultChecked: true,
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: MBtn(
                GeniusLinkLocalization.of(context).createWorkspace,
                full: true,
                onTap: () => unawaited(
                  controller.signUp('owner@new-co.example', 'New Workspace'),
                ),
              ),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: const SizedBox(height: 16),
            ),
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Center(
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
            ),
          ],
        ),
      ],
    );
  }
}

/// Presentation view extracted from `ForgotScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// ForgotPasswordView(
///   controller: controller,
///   emailController: emailController,
/// )
/// ```
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    super.key,
    required this.controller,
    required this.emailController,
  });

  final ForgotPasswordController controller;
  final SuperTextFieldController emailController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => AuthPageScaffold(
        title: Text(GeniusLinkLocalization.of(context).forgotPassword2),
        automaticallyImplyLeading: true,
        theme: AuthPageScaffoldThemeData(
          padding: const EdgeInsets.fromLTRB(28, 44, 28, 40),
        ),
        children: [
          SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AuthBrand(),
                    const SizedBox(height: 40),
                    if (!controller.sent) ...[
                      const AuthEyebrow(child: Text('PASSWORD RESET')),
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
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        GeniusLinkLocalization.of(
                          context,
                        ).enterTheEmailTiedToYourAccount,
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
                      const SizedBox(height: 16),
                      SuperTextFormField(
                        controller: emailController,
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
                        onTap: controller.sendResetLink,
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
                                    text: emailController.value.isEmpty
                                        ? 'you@company.com'
                                        : emailController.value,
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
                              GeniusLinkLocalization.of(
                                context,
                              ).useADifferentEmail,
                              variant: MBtnVariant.secondary,
                              full: true,
                              onTap: controller.useDifferentEmail,
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
            ],
          ),
        ],
      ),
    );
  }
}

TapGestureRecognizer _tap(VoidCallback onTap) =>
    TapGestureRecognizer()..onTap = onTap;
