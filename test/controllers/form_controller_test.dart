import 'package:flutter_test/flutter_test.dart';

import 'package:gl_mobile_app/core/state/load_status.dart';
import 'package:gl_mobile_app/shared/presentation/controllers/form_controller.dart';

void main() {
  group('FormController', () {
    test('setField preserves values and marks the form dirty', () {
      final controller = FormController(initial: const {'name': 'Before'});
      addTearDown(controller.dispose);

      controller.setField('name', 'After');

      expect(controller.state.value<String>('name'), 'After');
      expect(controller.state.dirty, isTrue);
    });

    test('submit preserves callback behavior and clears dirty state', () async {
      Map<String, Object?>? submitted;
      final controller = FormController(
        initial: const {'enabled': true},
        onSubmit: (values) async {
          submitted = Map.of(values);
        },
      );
      addTearDown(controller.dispose);
      controller.setField('enabled', false);

      final result = await controller.submit();

      expect(result, isTrue);
      expect(submitted, {'enabled': false});
      expect(controller.state.status, LoadStatus.ready);
      expect(controller.state.dirty, isFalse);
    });

    test('validation failure blocks submission', () async {
      var submitted = false;
      final controller = FormController(
        validator: (values) =>
            values['name'] == null ? {'name': 'Required'} : {},
        onSubmit: (_) async {
          submitted = true;
        },
      );
      addTearDown(controller.dispose);

      final result = await controller.submit();

      expect(result, isFalse);
      expect(submitted, isFalse);
      expect(controller.state.errors, {'name': 'Required'});
    });
  });
}
