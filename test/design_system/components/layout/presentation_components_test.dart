import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

void main() {
  testWidgets('DirectionalSlotTile renders positional slots', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DirectionalSlotTile(
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

  testWidgets('TwoRowTile keeps start/end semantic positions in RTL', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: TwoRowTile(
              title: Text('topStart'),
              trailing: Text('topEnd'),
              subtitle: Text('bottomStart'),
              subtitleTrailing: Text('bottomEnd'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('topStart'), findsOneWidget);
    expect(find.text('topEnd'), findsOneWidget);
    expect(find.text('bottomStart'), findsOneWidget);
    expect(find.text('bottomEnd'), findsOneWidget);
  });

  testWidgets('SegmentedSlotSelector exposes selected state', (tester) async {
    var value = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) => SegmentedSlotSelector(
            selectedIndex: value,
            onChanged: (next) => setState(() => value = next),
            options: const [Text('A'), Text('B')],
          ),
        ),
      ),
    );

    await tester.tap(find.text('B'));
    await tester.pump();
    expect(value, 1);
  });
}
