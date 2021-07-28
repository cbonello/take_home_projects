import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/src/stopwatch/stopwatch.dart';

void main() {
  group('Stopwatch', () {
    StopwatchCubit? stopwatchCubit;
    LapsCubit? lapsCubit;

    setUp(() {
      stopwatchCubit = StopwatchCubit();
      lapsCubit = LapsCubit();
    });

    tearDown(() {
      stopwatchCubit?.close();
    });

    testWidgets(
      'should be initially stopped',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<StopwatchCubit>.value(
                  value: stopwatchCubit!,
                ),
                BlocProvider<LapsCubit>.value(
                  value: lapsCubit!,
                ),
              ],
              child: const StopwatchView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isFalse);
      },
    );

    testWidgets(
      'should start when the play button is clicked',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<StopwatchCubit>.value(
                  value: stopwatchCubit!,
                ),
                BlocProvider<LapsCubit>.value(
                  value: lapsCubit!,
                ),
              ],
              child: const StopwatchView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final Finder playButton = find.byKey(
          const Key('StopwatchView_PlayButton'),
        );
        expect(playButton, findsOneWidget);
        await tester.tap(playButton);
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isTrue);

        // Test will fail if tmer is still running when test ends:
        //
        // ══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞══════════════════
        // The following assertion was thrown running a test:
        // A Timer is still pending even after the widget tree was disposed.
        // 'package:flutter_test/src/binding.dart':
        // Failed assertion: line 1245 pos 12: '!timersPending'
        stopwatchCubit!.stop();
      },
    );

    testWidgets(
      'should stop when the stop button is clicked',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<StopwatchCubit>.value(
                  value: stopwatchCubit!,
                ),
                BlocProvider<LapsCubit>.value(
                  value: lapsCubit!,
                ),
              ],
              child: const StopwatchView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final Finder playButton = find.byKey(
          const Key('StopwatchView_PlayButton'),
        );
        expect(playButton, findsOneWidget);
        await tester.tap(playButton);
        await tester.pumpAndSettle();

        final Finder stopButton = find.byKey(
          const Key('StopwatchView_StopButton'),
        );
        expect(stopButton, findsOneWidget);
        await tester.tap(stopButton);
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isFalse);
      },
    );

    testWidgets(
      'The lap button should be displayed when the timer is running',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<StopwatchCubit>.value(
                  value: stopwatchCubit!,
                ),
                BlocProvider<LapsCubit>.value(
                  value: lapsCubit!,
                ),
              ],
              child: const StopwatchView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final Finder playButton =
            find.byKey(const Key('StopwatchView_PlayButton'));
        expect(playButton, findsOneWidget);
        await tester.tap(playButton);
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isTrue);

        final Finder lapButton =
            find.byKey(const Key('StopwatchView_LapButton'));
        expect(lapButton, findsOneWidget);

        stopwatchCubit!.stop();
      },
    );

    testWidgets(
      'The lap button should not be displayed when the timer is stopped',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<StopwatchCubit>.value(
                  value: stopwatchCubit!,
                ),
                BlocProvider<LapsCubit>.value(
                  value: lapsCubit!,
                ),
              ],
              child: const StopwatchView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final Finder playButton =
            find.byKey(const Key('StopwatchView_PlayButton'));
        expect(playButton, findsOneWidget);
        await tester.tap(playButton);
        await tester.pumpAndSettle();

        final Finder stopButton =
            find.byKey(const Key('StopwatchView_StopButton'));
        expect(stopButton, findsOneWidget);
        await tester.tap(stopButton);
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isFalse);

        final Finder lapButton =
            find.byKey(const Key('StopwatchView_LapButton'));
        expect(lapButton, findsNothing);
      },
    );

    testWidgets(
      'A click on the lap button should record a lap',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<StopwatchCubit>.value(
                  value: stopwatchCubit!,
                ),
                BlocProvider<LapsCubit>.value(
                  value: lapsCubit!,
                ),
              ],
              child: const StopwatchView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final Finder playButton =
            find.byKey(const Key('StopwatchView_PlayButton'));
        expect(playButton, findsOneWidget);
        await tester.tap(playButton);
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isTrue);

        final Finder lapButton =
            find.byKey(const Key('StopwatchView_LapButton'));
        expect(lapButton, findsOneWidget);
        await tester.tap(lapButton);
        await tester.pumpAndSettle();

        expect(lapsCubit!.state.laps, isNotEmpty);

        stopwatchCubit!.stop();
      },
    );

    testWidgets(
      'A click on the play button should clear the lap(s) recorded',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<StopwatchCubit>.value(
                  value: stopwatchCubit!,
                ),
                BlocProvider<LapsCubit>.value(
                  value: lapsCubit!,
                ),
              ],
              child: const StopwatchView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final Finder playButton =
            find.byKey(const Key('StopwatchView_PlayButton'));
        expect(playButton, findsOneWidget);
        await tester.tap(playButton);
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isTrue);

        final Finder lapButton =
            find.byKey(const Key('StopwatchView_LapButton'));
        expect(lapButton, findsOneWidget);
        await tester.tap(lapButton);
        await tester.pumpAndSettle();

        expect(lapsCubit!.state.laps, isNotEmpty);

        final Finder stopButton =
            find.byKey(const Key('StopwatchView_StopButton'));
        expect(stopButton, findsOneWidget);
        await tester.tap(stopButton);
        await tester.pumpAndSettle();

        expect(stopwatchCubit!.isRunning, isFalse);

        await tester.tap(playButton);
        await tester.pumpAndSettle();

        expect(lapsCubit!.state.laps, isEmpty);

        stopwatchCubit!.stop();
      },
    );
  });
}
