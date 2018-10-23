# ToThem

A native TaskWarrior client for SailfishOS.

## Roles

**Max**\
Lead dev

**Franz**\
Frontend dev

**Sebi**\
Senior QA manager

**Alexander**\
Cloud deployments & rants

## User interface

### Main screen

This is very similar to the [Filter view](#filter_view), with a default filter that is listing of all *undone* tasks order by decending priority.

There is a top pulley menu for [Settings](#settings), [About](#about), and [Task creation](#task_creation).

To the right of the [Main screen](#main_screen) is the [Filter overview](#filter_overview).

### Filter overview

A list of all saved filters. Editing menu is available via the drop-down/context menu.

There is a pulley menu to create a new filter.

To the right of the [Filter overview](#filter_overview) is the [Filter view](#filter_view) for the selected filter.

### Filter creation

The filter creation allows the selection of filter criteria. It should be possible to create many filter attributes. There should also be the posibility to pick attributes to order the tasks by.

To the right of the [Filter creation](#filter_creation) is the [Filter view](#filter_view).

### Filter view

Listing the tasks that are returned by a filter. If the filter is not yet saved, the pulley menu has an item available to save the filter. Otherwise this option is not selectable. In the pulley menu, there should also be an item to [create a new task](#task_creation).

Clicking on a task in the list, will take you to the [Task view](#task_view) for that task, which is to the right of the [Filter view](#filter_view).

### Task view

A view listing a single task with all its attributes. There should be links to tasks that are dependend on this and its depenedencies. Clicking on a dependency will take you to the [Task view](#task_view) of the clicked task.

To the left of the screen is the originating screen, either the [Main screen](#main_screen) or the [Filter view](#filter_view).

### Task creation

This screen allows the user to create a new task.

To the left of the screen is the originating screen, either the [Main screen](#main_screen) or the [Filter view](#filter_view).


## TODO

[ ] integration with taskwarrior
  [x] taskwarrior python bindings?
    [x] dependencies (all for python3): 
       [x] python3-six
       [x] python-tasklib
       [x] python-pytz
       [x] python-tzlocal
  [ ] package everything for easy shipping to customers
  [ ] usage of taskwarrior bindings for managing tasks

[ ] filter views
[ ] release party
