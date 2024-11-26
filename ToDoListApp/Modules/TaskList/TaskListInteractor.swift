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
    private let taskManager: TaskManager
    
    init() {
        self.taskManager = TaskManager()
    }
    
    func fetchTasks() async throws -> [TaskModel] {
        return try await taskManager.fetchTasks()
    }
    
    func retrieveTasks() {
//        presenter?.didRetriveTasks() TODO: Resolve later
    }
    
    func saveTask(_ task: TaskModel) {
        TaskStore.init().addTask(task)
        presenter?.didAddTask(task)
    }
    
    func deleteTask(_ task: TaskModel) {
        TaskStore.init().removeTask(task)
        presenter?.didRemoveTask(task)
    }
}
