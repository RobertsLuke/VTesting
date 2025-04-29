import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sevenc_iteration_two/home/home_screen.dart';

void main() {
  testWidgets('Home screen UI elements and interactions', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Home(),
      ),
    );

    // Check if the title "Projects" exists
    expect(find.text('Projects'), findsOneWidget);

    // Check if the Add button exists
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the Add button (even if it does nothing yet)
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Check ListView.builder creates 3 project cards
    expect(find.byType(Card), findsNWidgets(3)); // Each project is wrapped in a Card

    // Check Project 1, Project 2, and Project 3 titles
    expect(find.text('Project 1'), findsOneWidget);
    expect(find.text('Project 2'), findsOneWidget);
    expect(find.text('Project 3'), findsOneWidget);

    // Check "5 members" appears 3 times
    expect(find.text('5 members'), findsNWidgets(3));

    // Check "75%" appears 3 times
    expect(find.text('75%'), findsNWidgets(3));

    // Scroll the list (even if not needed)
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();
  });
}
