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

class TaskModel {
    private let response: TodoResponse
    
    init(response: TodoResponse) {
        self.response = response
    }
    
    var id: UUID {
        response.id
    }
    
    var todo: String {
        response.todo
    }
    
    var isCompleted: Bool {
        response.completed
    }
    
    var date: String? 
    var desc: String?
}
