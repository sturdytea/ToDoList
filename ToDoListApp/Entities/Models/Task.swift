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
import Combine

final class Task: ObservableObject {
    
    private let response: TodoResponse
    private var subscriptions = Set<AnyCancellable>()
    private lazy var formatter = DateFormatter()
    
    var id: Int {
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
    
    init(_ response: TodoResponse) {
        self.response = response
    }
}
