// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/home/home_screen.dart';
import 'package:flutter_tests/models/cat_fact.dart';
import 'package:flutter_tests/repositories/cat_fact_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements CatfactRepository {}

void main() {
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
  });

  void arrangeRepositoryRequestFor2Seconds() {
    when(() => mockRepository.getCatFact()).thenAnswer((invocation) async {
      await Future.delayed(const Duration(seconds: 2));
      return CatFact(fact: 'mock test', length: 1);
    });
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Tests',
      home: HomeScreen(repository: mockRepository),
    );
  }

  testWidgets(
    "tapping on search button",
    (WidgetTester tester) async {
      arrangeRepositoryRequestFor2Seconds();
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.text('mock test'), findsOneWidget);
    },
  );
}
