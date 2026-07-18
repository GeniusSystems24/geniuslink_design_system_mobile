part of 'users_screens.dart';

class UsersListScreen extends StatelessWidget {
  final List<UserSummary> users;

  const UsersListScreen({
    required this.users,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListCubit<UserSummary>>(
      create: (_) => ListCubit<UserSummary>(
        source: () => users,
        predicate: userPredicate,
        initialFilters: const {'role': 'All'},
      )..load(),
      child: const UsersListView(),
    );
  }
}
