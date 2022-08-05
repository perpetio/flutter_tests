// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/home/cubit/home_cubit.dart';
import 'package:flutter_tests/home/home_screen.dart';
import 'package:flutter_tests/models/cat_fact.dart';
import 'package:flutter_tests/repositories/cat_fact_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements CatfactRepository {}

void main() {
  late MockRepository mockRepository;
  final CatFact catFact = CatFact(fact: 'mock test', length: 1);
  late HomeCubit cubit;

  setUp(() {
    mockRepository = MockRepository();
    cubit = HomeCubit(mockRepository);
  });

  void arrangeRepositoryReturnFact() {
    when(() => mockRepository.getCatFact()).thenAnswer((invocation) async => catFact);
  }

  group('Group testing example', () {
    test(
      "Check is request called once",
      () async {
        arrangeRepositoryReturnFact();
        cubit.loadCatFact();
        verify(() => mockRepository.getCatFact()).called(1);
      },
    );

    test(
      "Check is fact length more than 4 symbols",
      () async {
        arrangeRepositoryReturnFact();
        CatFact? catFact = await mockRepository.getCatFact();
        expect((catFact?.fact?.length ?? 0) > 4, true);
      },
    );
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Tests',
      home: HomeScreen(repository: mockRepository),
    );
  }

  testWidgets(
    "App bar widget test",
    (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Flutter tests'), findsOneWidget);
    },
  );

  testWidgets(
    "Search button is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byIcon(Icons.search), findsOneWidget);
    },
  );

  blocTest<HomeCubit, HomeState>('cubit test',
      setUp: arrangeRepositoryReturnFact,
      build: () => cubit,
      act: (bloc) => cubit.loadCatFact(),
      expect: () => <HomeState>[
            HomeLoading(),
            HomeMainState(catFact: catFact),
          ],
      verify: (_) async {
        verify((() => mockRepository.getCatFact())).called(1);
      });
}
