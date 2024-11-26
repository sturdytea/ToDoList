//
//
// Task.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

class MockTask {
    var id: Int
    var todo: String
    var isCompleted: Bool
    var date: String
    var desc: String?
    
    init(id: Int, todo: String, isCompleted: Bool, date: String, desc: String? = nil) {
        self.id = id
        self.todo = todo
        self.isCompleted = isCompleted
        self.date = date
        self.desc = desc
    }
}

