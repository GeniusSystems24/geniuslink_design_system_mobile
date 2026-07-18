part of 'users_screens.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListCubit<_UserRow>>(
      create: (_) => ListCubit<_UserRow>(
        source: () => _users(context),
        predicate: _userPredicate,
        initialFilters: const {'role': 'All'},
      )..load(),
      child: const UsersListView(),
    );
  }
}
