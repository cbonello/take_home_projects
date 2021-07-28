# Second Task

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

# Implementation

## Screenshots

Stopwatch Running | Stopwatch Stopped
--- | ---
![Running](./media/running.png?raw=true "Running") | ![Stopped](./media/stopped.png?raw=true "Stopped")

## Implementation

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management.

Code was tested on Android, Windows desktop and Flutter web.

## Testing

```bash
$ flutter test test
00:08 +7: All tests passed!
```