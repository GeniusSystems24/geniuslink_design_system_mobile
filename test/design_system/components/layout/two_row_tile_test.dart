import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

void main() {
  testWidgets('TwoRowTile renders all positional slots', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TwoRowTile(
            title: Text('top-start'),
            trailing: Text('top-end'),
            subtitle: Text('bottom-start'),
            subtitleTrailing: Text('bottom-end'),
          ),
        ),
      ),
    );

    expect(find.text('top-start'), findsOneWidget);
    expect(find.text('top-end'), findsOneWidget);
    expect(find.text('bottom-start'), findsOneWidget);
    expect(find.text('bottom-end'), findsOneWidget);
  });

  testWidgets('TwoRowTile exposes tap interaction', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TwoRowTile(
            title: const Text('action'),
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('action'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('TwoRowTile follows RTL start/end directionality', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SizedBox(
              width: 320,
              child: TwoRowTile(title: Text('start'), trailing: Text('end')),
            ),
          ),
        ),
      ),
    );

    final startX = tester.getCenter(find.text('start')).dx;
    final endX = tester.getCenter(find.text('end')).dx;

    expect(startX, greaterThan(endX));
  });
}
