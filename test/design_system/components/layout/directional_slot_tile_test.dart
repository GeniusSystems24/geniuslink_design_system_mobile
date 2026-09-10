import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

void main() {
  testWidgets('DirectionalSlotTile renders direct visual slots', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: DirectionalSlotTile(
            start: Text('start'),
            center: Text('center'),
            end: Text('end'),
          ),
        ),
      ),
    );

    expect(find.text('start'), findsOneWidget);
    expect(find.text('center'), findsOneWidget);
    expect(find.text('end'), findsOneWidget);
  });

  testWidgets('DirectionalSlotTile exposes tap callback', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: DirectionalSlotTile(
            center: const Text('tap'),
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('tap'));
    expect(tapped, isTrue);
  });

  testWidgets('DirectionalSlotTile respects RTL directionality', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Material(
            child: DirectionalSlotTile(
              start: Text('start'),
              end: Text('end'),
            ),
          ),
        ),
      ),
    );

    final start = tester.getCenter(find.text('start'));
    final end = tester.getCenter(find.text('end'));
    expect(start.dx, greaterThan(end.dx));
  });
}
