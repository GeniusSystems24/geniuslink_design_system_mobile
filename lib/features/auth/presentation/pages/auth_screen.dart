// ============================================================
// VIEW — Auth screens: Login · SignUp · Forgot Password
// (ports MLogin, MSignUp, MForgot)
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import 'package:flutter/gestures.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

class _Brand extends StatelessWidget {
  const _Brand();
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: M.blue, borderRadius: BorderRadius.circular(7)),
            alignment: Alignment.center,
            child: const Text('G', style: TextStyle(fontFamily: M.display, fontWeight: FontWeight.w800, fontSize: 17, color: Colors.white)),
          ),
          const SizedBox(width: 10),
          const Text('GeniusLink', style: TextStyle(fontFamily: M.display, fontWeight: FontWeight.w800, fontSize: 20, color: M.fg1, letterSpacing: -0.2)),
        ],
      );
}

Widget _authEyebrow(String text) => Text(text.toUpperCase(),
    style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 1.6, color: M.blue));

class LoginScreen extends StatelessWidget {
  final NavController nav;
  const LoginScreen({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: M.bg,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 48, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Brand(),
              const SizedBox(height: 40),
              _authEyebrow('Sign In'),
              const SizedBox(height: 14),
              const Text('Access your workspace',
                  style: TextStyle(fontFamily: M.display, fontWeight: FontWeight.w700, fontSize: 28, height: 1.25, letterSpacing: -0.7, color: M.fg1)),
              const SizedBox(height: 28),
              const TInput(label: 'Email', placeholder: 'you@company.com', defaultValue: 'layla.a@geniuslink.sa'),
              const SizedBox(height: 16),
              const TPassword(label: 'Password', placeholder: '••••••••••'),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => nav.showAuth(AuthScreen.forgot),
                  child: const Text('Forgot password?', style: TextStyle(fontSize: 12.5, color: M.blue, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 16),
              MBtn('Sign In to GeniusLink', full: true, onTap: nav.login),
              const SizedBox(height: 16),
              Center(
                child: Text.rich(TextSpan(children: [
                  const TextSpan(text: 'New organization?  ', style: TextStyle(fontFamily: M.body, fontSize: 12.5, color: M.fg3)),
                  TextSpan(
                    text: 'Create a workspace',
                    style: const TextStyle(fontFamily: M.body, fontSize: 12.5, color: M.blue, fontWeight: FontWeight.w600),
                    recognizer: _tap(() => nav.showAuth(AuthScreen.signup)),
                  ),
                ])),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: M.input, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lock_outline_rounded, size: 14, color: M.blue),
                    const SizedBox(width: 9),
                    Expanded(child: Text('Sessions are recorded in the audit log with timestamp and device.',
                        style: const TextStyle(fontFamily: M.body, fontSize: 11.5, color: M.fg3, height: 1.5))),
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
  final NavController nav;
  const SignUpScreen({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: M.bg,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 44, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Brand(),
              const SizedBox(height: 32),
              _authEyebrow('Create Account'),
              const SizedBox(height: 12),
              const Text('Provision a workspace',
                  style: TextStyle(fontFamily: M.display, fontWeight: FontWeight.w700, fontSize: 26, height: 1.25, letterSpacing: -0.65, color: M.fg1)),
              const SizedBox(height: 8),
              const Text("You'll be the workspace administrator.", style: TextStyle(fontFamily: M.body, fontSize: 13, color: M.fg3)),
              const SizedBox(height: 24),
              const TInput(label: 'Full Name', placeholder: 'e.g. Khalid Al-Rashid', required: true),
              const SizedBox(height: 16),
              const TInput(label: 'Work Email', placeholder: 'you@company.com', required: true),
              const SizedBox(height: 16),
              const TInput(label: 'Organization', placeholder: 'e.g. Al-Rashid Trading Co.', required: true),
              const SizedBox(height: 16),
              const TPassword(label: 'Password', required: true),
              const SizedBox(height: 16),
              const TCheckbox(label: 'I agree to the Terms of Service and Data Processing Agreement.', defaultChecked: true),
              const SizedBox(height: 16),
              MBtn('Create Workspace', full: true, onTap: nav.login),
              const SizedBox(height: 16),
              Center(
                child: Text.rich(TextSpan(children: [
                  const TextSpan(text: 'Already have an account?  ', style: TextStyle(fontFamily: M.body, fontSize: 13, color: M.fg3)),
                  TextSpan(
                    text: 'Sign in',
                    style: const TextStyle(fontFamily: M.body, fontSize: 13, color: M.blue, fontWeight: FontWeight.w600),
                    recognizer: _tap(() => nav.showAuth(AuthScreen.login)),
                  ),
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotScreen extends StatefulWidget {
  final NavController nav;
  const ForgotScreen({super.key, required this.nav});
  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool _sent = false;
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = widget.nav;
    return Container(
      color: M.bg,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 44, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Brand(),
              const SizedBox(height: 40),
              if (!_sent) ...[
                _authEyebrow('Password Reset'),
                const SizedBox(height: 12),
                const Text('Forgot password?',
                    style: TextStyle(fontFamily: M.display, fontWeight: FontWeight.w700, fontSize: 26, height: 1.25, letterSpacing: -0.65, color: M.fg1)),
                const SizedBox(height: 8),
                const Text('Enter the email tied to your account.', style: TextStyle(fontFamily: M.body, fontSize: 13, color: M.fg3)),
                const SizedBox(height: 16),
                Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _email,
                    cursorColor: M.blue,
                    style: const TextStyle(fontFamily: M.body, fontSize: 14, color: M.fg1),
                    decoration: const InputDecoration(isCollapsed: true, border: InputBorder.none, hintText: 'you@company.com', hintStyle: TextStyle(color: M.fg3)),
                  ),
                ),
                const SizedBox(height: 16),
                MBtn('Send Reset Link', full: true, onTap: () => setState(() => _sent = true)),
                const SizedBox(height: 16),
                Center(child: GestureDetector(onTap: () => nav.showAuth(AuthScreen.login),
                    child: const Text('Back to sign in', style: TextStyle(fontSize: 13, color: M.blue, fontWeight: FontWeight.w600)))),
              ] else ...[
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(color: tint(M.green, 0x1F), shape: BoxShape.circle, border: Border.all(color: tint(M.green, 0x66))),
                        child: const Icon(Icons.check_rounded, size: 24, color: M.green),
                      ),
                      const SizedBox(height: 20),
                      const Text('Check your inbox', style: TextStyle(fontFamily: M.display, fontWeight: FontWeight.w700, fontSize: 22, color: M.fg1)),
                      const SizedBox(height: 12),
                      Text.rich(
                        TextSpan(children: [
                          const TextSpan(text: 'A reset link was sent to\n'),
                          TextSpan(text: _email.text.isEmpty ? 'you@company.com' : _email.text, style: const TextStyle(color: M.fg1, fontFamily: M.mono)),
                          const TextSpan(text: '. It expires in 30 minutes.'),
                        ]),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontFamily: M.body, fontSize: 13, color: M.fg3, height: 1.6),
                      ),
                      const SizedBox(height: 28),
                      MBtn('Use a different email', variant: MBtnVariant.secondary, full: true, onTap: () => setState(() => _sent = false)),
                      const SizedBox(height: 10),
                      GestureDetector(onTap: () => nav.showAuth(AuthScreen.login),
                          child: const Text('Back to sign in', style: TextStyle(fontSize: 13, color: M.blue, fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// tiny tap-recognizer helper for inline links
TapGestureRecognizer _tap(VoidCallback onTap) => TapGestureRecognizer()..onTap = onTap;
