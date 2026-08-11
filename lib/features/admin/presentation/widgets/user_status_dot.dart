// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';

class UserStatusDot extends StatelessWidget {
  final Color color;
  const UserStatusDot(this.color, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: 6,
    height: 6,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
