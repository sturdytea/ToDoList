//
//
// TaskDetailsPresenter.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class TaskDetailsPresenter: TaskDetailsPresenterProtocol {
    
    var view: TaskDetailsViewProtocol?
    var interactor: TaskDetailsInteractorInputProtocol?
    var router: TaskDetailsRouterProtocol?
    
    func viewDidLoad() {
        if let task = interactor?.task {
            view?.showTask(task)
        }
    }
    
    func editTask(todo: String, desc: String) {
        interactor?.editTask(todo: todo, desc: desc)
    }
}

extension TaskDetailsPresenter: TaskDetailsInteractorOutputProtocol {
    
    func didEditTask(_ task: TaskModel) {
        view?.showTask(task)
    }
}
