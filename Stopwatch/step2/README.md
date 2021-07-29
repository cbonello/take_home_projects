# 1. Task Description

In the second task we will take the stopwatch and add some new features:

- A 'lap' button that is active while the timer is active
- A scrollable list of lap times

____

The list of lap times is not required to be in a specific position or have a
specific style, but it should also display the lap number next to the lap
time.

When a user taps the lap button, the current time should be recorded and added
to the list of lap times.

The list of lap times should reset when a new timer starts.

(Optional) Write a unit test to make sure this behavior works correctly.

____

Once finished, make a git commit and continue to the third task.

# 2. Implementation

## 2.1 State Management

The laps are managemened by the `LapsCubit` located in
`src/stopwatch/blocs/laps/laps_cubit.dart` and a new `LapModel` class was
introduced to record a lap.

## 2.2 Screenshots

Here is the end result: 

Stopwatch Stopped | Stopwatch Running
--- | ---
![Stopped](./media/stopped.png?raw=true "Stopped") | ![Running](./media/running.png?raw=true "Running")

## 2.3 Testing

I spent about 75 minutes on this step. It's probably a bit too much but I
added a feature to scroll the list of laps to display the last lap added.
I could have saved 15 minutes.

```bash
$ flutter test test
00:08 +7: All tests passed!
```