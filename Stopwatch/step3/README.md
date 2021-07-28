# Third Task

In the third (and final) task we will make some quality of life improvements
to the app:

- Keep the stopwatch running while the app is in the background
- Keep the stopwatch running while the app is killed and re-opened
- Keep the list of laps after the app is killed and re-opened

____

Here we want to make sure the user doesn't accidentally lose their time and
laps, the app should remain consistent regardless of whether or not it is in
the foreground.

The user should be able to switch back to the app and observe that the stopwatch
has increased at the same rate as it would while in the foreground.

This task will require persistent storage, use the library you are the most
comfortable with.

____

After you are finished, the project is ready to be submitted!

## Implementation

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management.

Code was tested on Android, Windows desktop and Flutter web.

The `stopwatch running in the background functionality` can be tested by doing a
hot restart (if running on an emulator).

## Testing

```bash
$ flutter test test
00:08 +7: All tests passed!
```