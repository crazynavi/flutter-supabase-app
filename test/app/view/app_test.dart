// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/app/app.dart';

import '../../helpers/helpers.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockSupabaseDatabaseRepository extends Mock
    implements SupabaseDatabaseRepository {}

void main() {
  late UserRepository userRepository;
  late SupabaseDatabaseRepository supabaseDatabaseRepository;

  group('App', () {
    setUpAll(() async {
      await initializeSupabase();
    });

    setUp(() async {
      userRepository = MockUserRepository();
      supabaseDatabaseRepository = MockSupabaseDatabaseRepository();
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpApp(
        App(
          supabaseDatabaseRepository: supabaseDatabaseRepository,
          userRepository: userRepository,
        ),
      );

      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
