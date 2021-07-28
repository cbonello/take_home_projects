import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/src/stopwatch/stopwatch.dart';

void main() {
  group('Stopwatch', () {
    StopwatchCubit? stopwatchCubit;

    setUp(() {
      stopwatchCubit = StopwatchCubit();
    });

    tearDown(() {
      stopwatchCubit?.close();
    });

    testWidgets(
      'should be initially stopped',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<StopwatchCubit>.value(
              value: stopwatchCubit!,
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
            home: BlocProvider<StopwatchCubit>.value(
              value: stopwatchCubit!,
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
            home: BlocProvider<StopwatchCubit>.value(
              value: stopwatchCubit!,
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
  });
}
