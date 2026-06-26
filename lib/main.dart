// ============================================================
// GeniusLink Mobile — entry point
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/bloc/app_bloc_observer.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const GeniusLinkApp());
}
