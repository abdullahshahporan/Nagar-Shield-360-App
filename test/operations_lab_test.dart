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

    await tester.scrollUntilVisible(find.text('এই স্থাপনা থেকে কাজের খসড়া'), 230,
        scrollable: find.byType(Scrollable).first);
    await tester.ensureVisible(find.text('এই স্থাপনা থেকে কাজের খসড়া'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('এই স্থাপনা থেকে কাজের খসড়া'));
    await tester.pumpAndSettle();
    for (var attempt = 0;
        attempt < 6 && find.text('নমুনা mission অনুমোদন').evaluate().isEmpty;
        attempt++) {
      await tester.drag(find.byType(ListView).first, const Offset(0, -350));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(find.text('নমুনা mission অনুমোদন'));
    await tester.pumpAndSettle();
    expect(find.text('একটি সমন্বিত কাজ'), findsOneWidget);
    await tester.tap(find.text('নমুনা mission অনুমোদন'));
    await tester.pumpAndSettle();
    expect(find.text('নমুনা অনুমোদন প্রত্যাহার'), findsOneWidget);
    for (var attempt = 0;
        attempt < 6 && find.text('নমুনা দলকে দায়িত্ব দিন').evaluate().isEmpty;
        attempt++) {
      await tester.drag(find.byType(ListView).first, const Offset(0, -300));
      await tester.pumpAndSettle();
    }
    final assign = find.text('নমুনা দলকে দায়িত্ব দিন').first;
    await tester.ensureVisible(assign);
    await tester.pumpAndSettle();
    await tester.tap(assign);
    await tester.pumpAndSettle();
    expect(find.text('দেওয়া · update দিন'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
