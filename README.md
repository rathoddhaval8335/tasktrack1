# tasktrack1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

-----------------------------Application Step--------------------------------------

1.Home (Default Screen)
     ->When the user opens the app → the Home Screen will open first.
     ->On the Home screen:Task status (Pending / Completed / Overdue).

2.Add Task (Drawer → Add)
   ->When the user selects Add from the navigation drawer:
     -> A form screen will open where the user can enter:
           ->Task Name
           ->Short Description
           ->Due Date & Time
           ->Priority (low/medium/high)
   ->After pressing the Save button, the task will appear in the Home screen list.

3.Edit Task (Drawer → Edit)
   ->A list of all tasks will be shown
   ->Click the edit icon than show the dailogbox
      ->The user can update:
         ->Task Name / Description
         ->Extend Due Date
         ->Mark as Completed
   ->Click The Save Textbutton changes are saved, the task list will update automatically.
      
4.Home Screen 
  -> All tasks are shown with TabBar for easy filtering:
    ->Tabbar (All/Complete/Pending)
    ->All
         → Shows all tasks (Pending + Completed).
    ->Completed
        -> Shows only completed tasks.
    ->Pending
        ->Shows only pending tasks (not completed yet).

5.Delete Task by Swipe Flow
     ->User swipes a task item (left or right). 
     ->Show delete icon while swiping.