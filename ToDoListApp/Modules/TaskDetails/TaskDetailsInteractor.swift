//
//
// TaskDetailsInteractor.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class TaskDetailsInteractor: TaskDetailsInteractorInputProtocol {
    
    var presenter: TaskDetailsInteractorOutputProtocol?
    var task: TaskEntity?
    private let taskManager: TaskManager
    private let coreDataManager: CoreDataManager
    
    init() {
        self.taskManager = TaskManager()
        self.coreDataManager = CoreDataManager()
    }
    
    func saveTask(_ title: String) {
        coreDataManager.createTask(title: title)
        presenter?.didAddTask(title)
    }
    
    func editTask(todo: String, desc: String) {
        guard let task = task else { return }
        
        if todo != "" && todo != task.todo {
            task.todo = todo
        }
        
        if desc != "" && desc != task.desc {
            task.desc = desc
        }
        presenter?.didEditTask(task)
    }
    
    func retrieveTasks() {
        let tasks = self.coreDataManager.getTasks()
        presenter?.didRetriveTasks(tasks)
    }
}
