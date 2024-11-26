//
//
// TaskManager.swift
// ToDoListApp
//
// Created by sturdytea on 26.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

class TaskManager {
    private let url = "https://dummyjson.com/todos"
    private lazy var decoder = JSONDecoder()
    
    func fetchTasks() async throws -> [TaskModel] {
        guard let url = URL(string: url) else {
            throw TaskError.network
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TaskError.responseCodeError
        }
        
        do {
            let decodedResponse = try decoder.decode(TaskResponseBody.self, from: data)
            print(decodedResponse)
            
            let tasks: [TaskModel] = decodedResponse.todos
                .map({ item in
                    TaskModel(response: item)
                })
            print(tasks)
            return tasks
        } catch {
            throw TaskError.invalidData
        }
    }
}
