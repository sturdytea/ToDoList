//
//
// TodoResponse.swift
// ToDoListApp
//
// Created by sturdytea on 26.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct TodoResponse: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let date: Date?
    let desc: String?
}
