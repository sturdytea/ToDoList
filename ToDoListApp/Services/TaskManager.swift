//
//
// TaskManager.swift
// ToDoListApp
//
// Created by sturdytea on 25.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class TaskManager {
    private let seesion: URLSession
    private var subscriptions = Set<AnyCancellable>()
    private lazy var decoder = JSONDecoder()
    private let url = "https://dummyjson.com/todos"
    
    init(seesion: URLSession = .shared) {
        self.seesion = seesion
    }
    
    func taskPublisher() -> AnyPublisher<TaskResponseBody, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: TaskError.networking).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TaskResponseBody.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
