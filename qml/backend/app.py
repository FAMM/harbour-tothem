import pyotherside
import threading
import time
import random

class Task:
    def __init__(self, id, done, description, due, created_at):
        self.id = id
        self.done = done
        self.description = description
        self.due = due
        self.created_at = created_at

    def to_dict(self):
        return {'id': self.id, 'done': self.done, 'description': self.description, 'due': self.due}



class TaskList:
    def __init__(self):
        self._tasks = []
        self.add_seeds()
        pyotherside.send('finished')

    def get_tasks(self):
        #map(lambda x: .to_dict, self._tasks)]
        return [ {"id": 0, "description": "Blablub", "done": False} ]

    def add_task(self, id, description, done, due, created_at):
        task = Task(id, description, done, due, created_at)
        self._tasks.append(task)

    def get_task_by_id(self, id):
        for task in self._tasks:
            if task.id == id:
                return task
        return None

    def add_seeds(self):
        self.add_task(0, "Blubb0", False, 0, 0)
        self.add_task(1, "Blubb1", False, 0, 0)
        self.add_task(2, "Blubb2", False, 0, 0)
        self.add_task(3, "Blubb3", True, 0, 0)

tasklist = TaskList()
