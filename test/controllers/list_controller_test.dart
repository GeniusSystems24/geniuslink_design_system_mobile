import 'package:flutter_test/flutter_test.dart';

import 'package:gl_mobile_app/core/state/load_status.dart';
import 'package:gl_mobile_app/shared/presentation/controllers/list_controller.dart';

void main() {
  group('ListController', () {
    late ListController<String> controller;

    setUp(() {
      controller = ListController<String>(
        source: () => const ['Admin', 'Accountant', 'Viewer'],
        initialFilters: const {'prefix': ''},
        predicate: (item, query, filters) {
          final normalized = query.trim().toLowerCase();
          final prefix = (filters['prefix'] as String?) ?? '';
          return item.startsWith(prefix) &&
              (normalized.isEmpty || item.toLowerCase().contains(normalized));
        },
      );
    });

    tearDown(() => controller.dispose());

    test('load publishes source results and ready status', () async {
      await controller.load();

      expect(controller.state.status, LoadStatus.ready);
      expect(controller.state.all, ['Admin', 'Accountant', 'Viewer']);
      expect(controller.state.results, ['Admin', 'Accountant', 'Viewer']);
    });

    test('query and filters preserve current filtering semantics', () async {
      await controller.load();

      controller.setQuery('a');
      expect(controller.state.results, ['Admin', 'Accountant']);

      controller.setFilter('prefix', 'Acc');
      expect(controller.state.results, ['Accountant']);
      expect(controller.state.filters['prefix'], 'Acc');
      expect(controller.state.query, 'a');
    });
  });
}
