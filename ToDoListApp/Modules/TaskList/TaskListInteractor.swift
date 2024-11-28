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
    private let taskManager = TaskManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    func fetchTasks() async throws -> [TaskEntity] {
        
        if isFirstLaunch() {
            let tasks = try await taskManager.fetchTasks()
            coreDataManager.taskEntities = tasks
        }
        return coreDataManager.getTasks()
    }
    
    func retrieveTasks() {
        presenter?.didRetriveTasks(coreDataManager.getTasks()) 
    }
    
    func deleteTask(_ task: TaskEntity) {
        coreDataManager.deleteTask(entity: task)
        presenter?.didRemoveTask(task)
    }
    
    private func isFirstLaunch() -> Bool {
        let hasFetchedDataKey = "hasFetchedData"
        let defaults = UserDefaults.standard
        
        if !defaults.bool(forKey: hasFetchedDataKey) {
            defaults.set(true, forKey: hasFetchedDataKey)
            return true
        }
        return false
    }
}
