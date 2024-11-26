//
//
// TaskResponseBody.swift
// ToDoListApp
//
// Created by sturdytea on 25.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct TaskResponseBody: Decodable {
    let todos: [TodoResponse]
}

struct TodoResponse: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
}
