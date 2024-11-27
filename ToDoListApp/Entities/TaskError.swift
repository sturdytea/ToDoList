//
//
// TaskError.swift
// ToDoListApp
//
// Created by sturdytea on 26.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

enum TaskError: Error {
    case network, responseCodeError, invalidData, fetchError
}
