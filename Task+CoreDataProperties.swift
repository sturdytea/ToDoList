//
//
// Task+CoreDataProperties.swift
// ToDoListApp
//
// Created by sturdytea on 25.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var date: Date?
    @NSManaged public var desc: String?

}

extension Task : Identifiable {

}
