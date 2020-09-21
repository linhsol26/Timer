import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/timer_bloc.dart';
import 'bloc/timer_event.dart';
import 'bloc/timer_state.dart';

class ActionsTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionsButton(
        timerBloc: BlocProvider.of<TimerBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionsButton({TimerBloc timerBloc}) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(
            TimerStarted(duration: currentState.duration),
          ),
        ),
      ];
    }

    if (currentState is TimerRunInProgress) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.add(TimerPaused()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        )
      ];
    }

    if (currentState is TimerRunPause) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(TimerResumed()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }

    if (currentState is TimerRunComplete) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    return [];
  }
}
