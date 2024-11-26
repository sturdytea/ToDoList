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

struct TaskResponseBody {
    let todos: [Todo]
}

struct Todo {
    let id: Int
    let todo: String
    let completed: Bool
}
