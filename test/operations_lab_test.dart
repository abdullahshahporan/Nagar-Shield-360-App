import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nagar_shield_360/ui/operations_lab.dart';

void main() {
  testWidgets('seeded city operation opens and advances on a narrow phone',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: OperationsLab(bangla: true)),
    ));
    await tester.pumpAndSettle();

    expect(find.text('বাজার করিডর: বর্জ্য, ড্রেন ও হাঁটার পথ'), findsWidgets);

    await tester.scrollUntilVisible(find.text('3. কাজ'), 230,
        scrollable: find.byType(Scrollable).first);
    await tester.ensureVisible(find.text('3. কাজ'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3. কাজ'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('নমুনা mission অনুমোদন'), 230,
        scrollable: find.byType(Scrollable).first);
    await tester.ensureVisible(find.text('নমুনা mission অনুমোদন'));
    await tester.pumpAndSettle();
    expect(find.text('একটি সমন্বিত কাজ'), findsOneWidget);
    await tester.tap(find.text('নমুনা mission অনুমোদন'));
    await tester.pumpAndSettle();
    expect(find.text('নমুনা অনুমোদন প্রত্যাহার'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
