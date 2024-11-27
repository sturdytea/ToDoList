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
    private let taskManager = TaskManager()
    private let coreDataManager = CoreDataManager()
    
    func fetchTasks() async throws -> [TaskEntity] {
//        return try await taskManager.fetchTasks() TODO: Get tasks from API on first launch 
        return coreDataManager.getTasks()
    }
    
    func retrieveTasks() {
        presenter?.didRetriveTasks(coreDataManager.getTasks()) 
    }
    
    func deleteTask(_ task: TaskEntity) {
        coreDataManager.deleteTask(entity: task)
        presenter?.didRemoveTask(task)
    }
}
