//
//
// TaskStore.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

class TaskStore {
    var tasks: [TaskEntity] = []
    
    func addTask(_ task: TaskEntity) {
        tasks.append(task)
    }
    
    func removeTask(_ task: TaskEntity) {
        if let index = tasks.firstIndex(where: { $0 as! AnyHashable == task as! AnyHashable}) {
            tasks.remove(at: index)
        }
    }
}
