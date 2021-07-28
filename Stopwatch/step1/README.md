# First Task

Your first task is to create a simple home page containing the following elements:

- Start / Stop button
- Visual display of elapse time

____

When a user presses the start button, the time display should start incrementing,
and stop when the stop button is pressed.

(Optional) Write a unit test to make sure this behavior works correctly.

If you are unsure about a design feel free to take inspiration from [Dribbble](https://dribbble.com/search/stopwatch).

Use the state management approach you are most conmfortable with.

____

Once finished, make a git commit and continue to the second task.

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
00:11 +3: All tests passed!
```