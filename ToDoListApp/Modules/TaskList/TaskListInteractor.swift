//
//
// TaskListInteractor.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class TaskListInteractor: TaskListInteractorInputProtocol {
    var presenter: TaskListInteractorOutputProtocol?
    var tasks: [Task] {
        return TaskStore.init().tasks
    }
    
    func retrieveTasks() {
        presenter?.didRetriveTasks(tasks)
    }
    
    func saveTask(_ task: Task) {
        TaskStore.init().addTask(task)
        presenter?.didAddTask(task)
    }
    
    func deleteTask(_ task: Task) {
        TaskStore.init().removeTask(task)
        presenter?.didRemoveTask(task)
    }
}
