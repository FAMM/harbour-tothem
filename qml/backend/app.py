import pyotherside
import threading
import time
import random
import uuid

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

    def get_task_by_uuid(self, uuid):
        return next(task for task in self._tasks if task.uuid == uuid)

    def add_seeds(self):
        self._tasks.append(Task.create("Blubb0", False, 0, 0))
        self._tasks.append(Task.create("Blubb1", False, 0, 0))
        self._tasks.append(Task.create("Blubb2", False, 0, 0))
        self._tasks.append(Task.create("Blubb3", True, 0, 0))

tasklist = TaskList()
