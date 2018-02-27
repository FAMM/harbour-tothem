import os
import pickle
import pyotherside
import random
import threading
import time
import uuid

DEFAULT_SAVE_PATH="~/.harbour-tothem.pickle"

class Task:
    global_id = 0

    def create(description, done, due, created_at):
        Task.global_id = Task.global_id + 1
        return Task(Task.global_id, str(uuid.uuid1()), description, done, due, created_at)

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
            'due': self.due
            }

class TaskList:
    def __init__(self):
        self._tasks = []
        self.add_seeds()
        pyotherside.send('finished')

    def get_tasks(self):
        return [task.to_dict() for task in self._tasks]

    def add_task(self, description, done, due, created_at):
        task = Task.create(description, done, due, created_at)
        self._tasks.append(task)
        pyotherside.send('tasks_updated')

    def update_task(self, uuid, description, done, due, created_at):
        task = self.get_task_by_uuid(uuid)
        task.description = description
        task.done = done
        task.due = due
        task.created_at = created_at
        pyotherside.send('tasks_updated')

    def remove_task(self, uuid):
        self._tasks.remove(self.get_task_by_uuid(uuid))
        pyotherside.send('tasks_updated')

    def get_task_by_uuid(self, uuid):
        return next(task for task in self._tasks if task.uuid == uuid)

    def add_seeds(self):
        self._tasks.append(Task.create("Blubb0", False, 0, 0))
        self._tasks.append(Task.create("Blubb1", False, 0, 0))
        self._tasks.append(Task.create("Blubb2", False, 0, 0))
        self._tasks.append(Task.create("Blubb3", True, 0, 0))

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
