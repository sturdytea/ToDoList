//
//
// MockCoreDataManager.swift
// ToDoListApp
//
// Created by sturdytea on 29.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation
@testable import ToDoListApp

final class MockCoreDataManager: CoreDataManager {
    var createdTaskTitle: String?
    var updatedTaskName: String?
    var updatedTaskDesc: String?
    
    override func createTask(title: String) {
        createdTaskTitle = title
    }
    
    override func updateTask(entity: TaskEntity, newName: String, newDesc: String) {
        updatedTaskName = newName
        updatedTaskDesc = newDesc
    }
}
