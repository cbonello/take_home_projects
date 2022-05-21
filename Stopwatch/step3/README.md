# 1. Task Description

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

# 2. Implementation

In this last step we’ll have to deal with is a common feature of take-home
tests: JSON serialization / deserialization.
[`json_serializable`](https://pub.dev/packages/json_serializable)
is usually my go to package for JSON, but to save time I simply took advantage
of the
[`Dart Data Class Generator`](https://marketplace.visualstudio.com/items?itemName=BendixMa.dart-data-class-generator)
extension of vscode to quickly generate `toJson()` and `fromJson()` functions
for my list of LapModel (see `laps_cubit.dart` file.)

The start time and laps were saved to local storage using the
[`shared_preference`](https://pub.dev/packages/shared_preferences) package.
I probably would have used [`sembast`](https://pub.dev/packages/sembast)
in a production app since `shared_preference`must not be used for storing
critical data. However, it is fine for our demo.

I spent about 1 hour on this step.
