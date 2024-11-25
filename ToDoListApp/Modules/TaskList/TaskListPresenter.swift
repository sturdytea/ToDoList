//
//
// TaskListPresenter.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class TaskListPresenter: TaskListPresenterProtocol {
    
    var view: TaskListViewProtocol?
    var interactor: TaskListInteractorInputProtocol?
    var router: TaskListRouterProtocol?
    
    func viewWillAppear() {
        interactor?.retrieveTasks()
    }
    
    func showTaskDetails(_ task: Task) {
        guard let view = view else { return }
        router?.presentTaskDetailsScreen(from: view, for: task)
    }
    
    func addTask(_ task: Task) {
        interactor?.saveTask(task)
    }
    
    func removeTask(_ task: Task) {
        interactor?.deleteTask(task)
    }
}

extension TaskListPresenter: TaskListInteractorOutputProtocol {
    
    func didAddTask(_ task: Task) {
        interactor?.retrieveTasks()
    }
    
    func didRemoveTask(_ task: Task) {
        interactor?.retrieveTasks()
    }
    
    func didRetriveTasks(_ tasks: [Task]) {
        view?.showTasks(tasks)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
