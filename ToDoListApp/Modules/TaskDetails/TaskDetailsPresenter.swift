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
    var listView: TaskListViewProtocol?
    var interactor: TaskDetailsInteractorInputProtocol?
    var router: TaskDetailsRouterProtocol?
    
    func viewDidLoad() {
        if let task = interactor?.task {
            view?.showTask(task)
        }
    }
    
    func addTask(_ title: String) {
        interactor?.saveTask(title)
    }
    
    func editTask(todo: String, desc: String) {
        interactor?.editTask(todo: todo, desc: desc)
    }
}

extension TaskDetailsPresenter: TaskDetailsInteractorOutputProtocol {
    
    func didAddTask(_ title: String) {
        interactor?.retrieveTasks()
    }

    func didEditTask(_ task: TaskEntity) {
        view?.showTask(task)
    }
    
    func didRetriveTasks(_ tasks: [TaskEntity]) {
        
            self.listView?.showTasks(tasks)
        
    }
}
