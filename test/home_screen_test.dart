import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sevenc_iteration_two/home/home.dart';
import 'package:sevenc_iteration_two/providers/projects_provider.dart';
import 'package:sevenc_iteration_two/providers/tasks_provider.dart';
import 'package:sevenc_iteration_two/usser/usserObject.dart';
import 'mocks.dart';

void main() {
  Widget createHomeScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Usser>(create: (_) => MockUsser()),
        ChangeNotifierProvider<ProjectsProvider>(create: (_) => MockProjectsProvider()),
        ChangeNotifierProvider<TaskProvider>(create: (_) => MockTaskProvider()),
      ],
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }

  testWidgets(
    'Home screen renders without crashing',
    (WidgetTester tester) async {
      // Set a larger surface size to avoid overflow errors
      tester.view.physicalSize = const Size(1000, 1000);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(createHomeScreen());
      
      // Reset the surface size after the test
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      
      expect(find.byType(Home), findsOneWidget);
    },
  );

  testWidgets(
    'Home screen contains at least one Column',
    (WidgetTester tester) async {
      // Set a larger surface size to avoid overflow errors
      tester.view.physicalSize = const Size(1000, 1000);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(createHomeScreen());
      await tester.pump(); // Allow for async rendering
      
      // Reset the surface size after the test
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      
      expect(find.byType(Column), findsWidgets);
    },
  );

  testWidgets(
    'Home screen contains at least one Expanded widget',
    (WidgetTester tester) async {
      // Set a larger surface size to avoid overflow errors
      tester.view.physicalSize = const Size(1000, 1000);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(createHomeScreen());
      await tester.pump(); // Allow for async rendering
      
      // Reset the surface size after the test
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      
      expect(find.byType(Expanded), findsWidgets);
    },
  );

  testWidgets(
    'Home screen contains at least one Padding widget',
    (WidgetTester tester) async {
      // Set a larger surface size to avoid overflow errors
      tester.view.physicalSize = const Size(1000, 1000);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(createHomeScreen());
      await tester.pump(); // Allow for async rendering
      
      // Reset the surface size after the test
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      
      expect(find.byType(Padding), findsWidgets);
    },
  );
}