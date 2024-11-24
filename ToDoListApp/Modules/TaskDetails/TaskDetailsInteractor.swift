//
//
// TaskDetailsInteractor.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class TaskDetailsInteractor: TaskDetailsInteractorInputProtocol {
    
    var presenter: TaskDetailsInteractorOutputProtocol?
    var task: Task?
    
    func editTask(todo: String, desc: String) {
        guard let task = task else { return }
        task.todo = todo
        task.desc = desc
        presenter?.didEditTask(task)
    }
}
