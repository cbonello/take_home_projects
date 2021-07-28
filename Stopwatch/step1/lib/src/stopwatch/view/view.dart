import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../stopwatch.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StopwatchCubit>(
      create: (BuildContext context) => StopwatchCubit(),
      child: const StopwatchView(),
    );
  }
}

class StopwatchView extends StatefulWidget {
  const StopwatchView({Key? key}) : super(key: key);

  @override
  _StopwatchViewState createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const <Widget>[
              Expanded(child: _TimeDisplay()),
              _ActionBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeDisplay extends StatelessWidget {
  const _TimeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopwatchCubit, StopwatchState>(
      builder: (BuildContext context, StopwatchState state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              state.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        );
      },
    );
  }
}

class _ActionBar extends StatefulWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (isRunning == false)
          IconButton(
            icon: const Icon(
              Icons.play_circle,
              key: Key('StopwatchView_PlayButton'),
            ),
            iconSize: 48.0,
            tooltip: 'Start stopwatch',
            onPressed: () {
              context.read<StopwatchCubit>().start();
              setState(() => isRunning = true);
            },
          )
        else
          IconButton(
            icon: const Icon(
              Icons.stop_circle_outlined,
              key: Key('StopwatchView_StopButton'),
            ),
            iconSize: 48.0,
            tooltip: 'Stop stopwatch',
            onPressed: () {
              setState(() => isRunning = false);
              context.read<StopwatchCubit>().stop();
            },
          ),
      ],
    );
  }
}
