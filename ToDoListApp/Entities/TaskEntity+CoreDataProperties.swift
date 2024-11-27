//
//
// TaskEntity+CoreDataProperties.swift
// ToDoListApp
//
// Created by sturdytea on 27.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var todo: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var date: Date?
    @NSManaged public var desc: String?

}

extension TaskEntity : Identifiable {

}
