import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme.dart';
import '../stopwatch.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<StopwatchCubit>(
          create: (BuildContext context) => StopwatchCubit(),
        ),
        BlocProvider<LapsCubit>(
          create: (BuildContext context) => LapsCubit(),
        ),
      ],
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
              _TimeDisplay(),
              Expanded(child: _LapsDisplay()),
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

class _LapsDisplay extends StatefulWidget {
  const _LapsDisplay({Key? key}) : super(key: key);

  @override
  __LapsDisplayState createState() => __LapsDisplayState();
}

class __LapsDisplayState extends State<_LapsDisplay> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // See https://stackoverflow.com/a/63044178/12120177
  void _onAfterBuild(BuildContext context) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LapsCubit, LapsState>(
      builder: (BuildContext context, LapsState state) {
        // Jump to end of list when a new item is added so that it is visible.
        WidgetsBinding.instance?.addPostFrameCallback(
          (_) => _onAfterBuild(context),
        );

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: StopwatchTheme.lightPurple,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lap times',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: state.laps.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          key: const Key('StopwatchView_LapsDisplay'),
                          dense: true,
                          leading: Text(
                            '${state.laps[index].lapNumber}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          title: Text(
                            state.laps[index].toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              // Clear laps and start the stopwatch.
              context.read<LapsCubit>().clear();
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
        if (isRunning)
          ElevatedButton.icon(
            key: const Key('StopwatchView_LapButton'),
            icon: const Icon(Icons.timer),
            label: const Text(
              'LAP',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              final StopwatchState state = context.read<StopwatchCubit>().state;
              context.read<LapsCubit>().add(
                    state.hours,
                    state.minutes,
                    state.seconds,
                  );
            },
          ),
      ],
    );
  }
}
