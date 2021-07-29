# 1. Project Description

## 1.1 Goals

The goal of this take home project is to create a simple stopwatch for a
fitness tracking app. It should take less than 3 hours to complete. Don't
worry about finishing each task before time run out, we care much about
quality over quantity.

You are free to refer to API documentation, byt you should not get external
help when completing this project.

## 1.2 Preparation

Before starting:

1. Prepare your development environment of choice
1. Create a new Flutter app from the default template.
1. (recommended) initialize a git repository to keep track of changes.

Continue to the first task when you are ready!

## 1.3 Tasks

[First Task](step1/README.md)

[Second Task](step2/README.md)

[Third Task](step3/README.md)

## 1.4 Submission

To submit your project you can either publish it to a public git repository
or mkae a zip file. If sumitting a zip file make sure to `flutter clean` to
remove any build artifacts.

# 2. Implementation

With projects like this one that have successive tasks that are built upon each
other, it is very important to have a global view of the problem. For instance,
what if you only read the description of the first step, make assumptions, and
start an implementation, only to realize in a subsequent step that your original
solution is not going to work. Those three hours will go very fast. You must
plan your work.

I started by taking a few minutes to read and understand each step. Obviously
the third step seems to be the most challenging and the description makes a job
at confusing you a little bit. You don’t want to run the app in the background.
It can be done, but not in three hours, I think. And you don’t have to. Here is
the solution I implemented:

1. Save the start time in local storage when the timer starts.
1. Remove the start time from local storage when the timer is stopped.

Now, when the app starts, we read the start time from local storage. If nothing
is saved the timer was not running when the app was stopped or put to sleep. If
a start time was saved, we automatically restart the timer with the difference
between the actual time and the time saved.
