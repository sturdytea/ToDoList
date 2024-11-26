//
//
// TaskResponseBody.swift
// ToDoListApp
//
// Created by sturdytea on 26.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct TaskResponseBody: Decodable {
    let todos: [TodoResponse]
}
