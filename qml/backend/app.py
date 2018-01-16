from tasks import task

tasks = []

def add_task(id, description, done, due, created_at):
    task = Task(id, description, done, due, created_at)
    tasks.append(task)

def get_task_by_id(id):
    for task in tasks:
        return task if task.id == id
    return None    
