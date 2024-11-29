//
//
// CoreDataManager.swift
// ToDoListApp
//
// Created by sturdytea on 27.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    public var taskEntities: [TaskEntity] = []
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() { }
    
    func getTasks() -> [TaskEntity] {
        do {
            taskEntities = try context.fetch(TaskEntity.fetchRequest())
        } catch {
            print(TaskError.fetchError)
        }
        return taskEntities
    }
    
    func createTask(title: String) {
        let newTask = TaskEntity(context: context)
        
        guard !title.isEmpty else { return }
        
        newTask.id = UUID()
        newTask.todo = title
        newTask.isCompleted = false
        newTask.date = Date()
        
        do {
            try context.save()
        } catch {
            print("CoreDataManager() Error")
        }
    }
    
    func deleteTask(entity: TaskEntity) {
        context.delete(entity)
        do {
            try context.save()
        } catch {
            print("CoreDataManager() Error")
        }
    }
    
    func updateTask(entity: TaskEntity, newName: String = "attributeDidNotChange", newDesc: String = "attributeDidNotChange") {
        
        if newName != "attributeDidNotChange" {
            entity.todo = newName
        }
        
        if newDesc != "attributeDidNotChange" {
            entity.desc = newDesc
        }
        
        do {
            try context.save()
        } catch {
            print("CoreDataManager() Error")
        }
    }
}
