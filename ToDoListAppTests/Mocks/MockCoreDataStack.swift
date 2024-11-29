//
//
// MockCoreDataStack.swift
// ToDoListApp
//
// Created by sturdytea on 29.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation
import CoreData

final class MockCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        
        let container = NSPersistentContainer(name: "ToDoListApp")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }    
}
