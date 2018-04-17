import os
import pickle
import pyotherside
import random
import threading
import time
import uuid
import datetime

DEFAULT_SAVE_PATH="~/.harbour-tothem.pickle"

class Task:
    global_id = 0

    def create(description, done, due):
        Task.global_id = Task.global_id + 1
        return Task(Task.global_id, str(uuid.uuid1()), description, done, due, datetime.datetime.now())

    def __init__(self, id, uuid, description, done, due, created_at):
        self.id = id
        self.uuid = uuid
        self.done = done
        self.description = description
        self.due = due
        self.created_at = created_at

    def to_dict(self):
        return {
            'id': self.id,
            'uuid': self.uuid,
            'done': self.done,
            'description': self.description,
            'due': self.due,
            'created_at': self.created_at
        }

class TaskList:
    def __init__(self):
        self._tasks = []
        pyotherside.send('finished')

    def get_tasks(self):
        return [task.to_dict() for task in self._tasks]

    def add_task(self, description, done, due):
        task = Task.create(description, done, due)
        self._tasks.append(task)
        pyotherside.send('tasks_updated')

    def update_task(self, uuid, description, done, due):
        print(str(due))
        task = self.get_task_by_uuid(uuid)
        task.description = description
        task.done = done
        task.due = due
        pyotherside.send('tasks_updated')

    def remove_task(self, uuid):
        self._tasks.remove(self.get_task_by_uuid(uuid))
        pyotherside.send('tasks_updated')

    def get_task_by_uuid(self, uuid):
        try:
            return next(task for task in self._tasks if task.uuid == uuid)
        except StopIteration:
            return None

    # TODO! How to handle mix of .to_dict() and python-object returns?
    def get_next_open_task(self, uuid):
        if len(self._tasks) == 0:
            return None

        if len(self._tasks) == 1:
            current_task = self._tasks[0]
            if not current_task.done:
                return current_task.to_dict()

            return None

        index = 0
        open_tasks = [task for task in self._tasks if not task.done]
        if not open_tasks:
            return None
        if uuid:
            current_task = self.get_task_by_uuid(uuid)
            try:
                index = open_tasks.index(current_task) + 1
            except ValueError:
                pass
            if index >= len(open_tasks):
                index = 0
        return open_tasks[index].to_dict()

    def save_to_file(self):
        with open(os.path.expanduser(DEFAULT_SAVE_PATH), 'wb') as handle:
            pyotherside.send('got_write_handle')
            pickle.dump(self._tasks, handle, protocol=pickle.HIGHEST_PROTOCOL)

    def read_from_file(self):
        with open(os.path.expanduser(DEFAULT_SAVE_PATH), 'rb') as handle:
            pyotherside.send('got_read_handle')
            self._tasks = pickle.load(handle)
        pyotherside.send('tasks_updated')

tasklist = TaskList()
