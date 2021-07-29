# 1. Task Description

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

# 2. Implementation

## 2.1 State Management

My go to state management approach is BLoC. And I have used the
[flutter_bloc](https://pub.dev/packages/flutter_bloc) library.

The timer is managed by a [`Cubit`](https://bloclibrary.dev/#/coreconcepts?id=cubit)
and a [`Stream.periodic()`](https://api.flutter.dev/flutter/dart-async/Stream/Stream.periodic.html)
with a one second period (the task description does not mention any periodicity
for the timer.)

## 2.2 Design

I chose a design from
[Rahmat Raditya](https://dribbble.com/shots/11164774-Clock-Apps-Design-Exploration)
because I like the color scheme. But I am not planning to replicate the design.
I'll keep things simple.

![Design](./media/design.png?raw=true "Design")

## 2.3 Screenshots

Here is the end result. It does not exactely look like
[Rahmat Raditya](https://dribbble.com/shots/11164774-Clock-Apps-Design-Exploration)
color scheme yet, but we'll fix it in the next step.

I spent about 45 minutes on this step.

Stopwatch Stopped | Stopwatch Running
--- | ---
![Stopped](./media/stopped.png?raw=true "Stopped") | ![Running](./media/running.png?raw=true "Running")

## 2.4 Testing

Code was tested on Android and Windows desktop. It should work on MacOS, Linux and
web as well.

```bash
$ flutter test test
00:11 +3: All tests passed!
```