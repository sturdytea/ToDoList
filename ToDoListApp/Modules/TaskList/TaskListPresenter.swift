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
    
    func loadTasks() async {
        Task {
            do {
                let tasks = try await interactor?.fetchTasks()
                DispatchQueue.main.async {
                    self.view?.showTasks(tasks ?? [])
                }
            } catch {
                DispatchQueue.main.async {
                    self.view?.showErrorMessage("loadTasks() Error: Cannot load data")
                }
            }
        }
    }
    
    func viewWillAppear() {
        interactor?.retrieveTasks()
    }
    
    func showTaskDetails(_ task: TaskEntity) {
        guard let view = view else { return }
        router?.presentTaskDetailsScreen(from: view, for: task)
    }
    
    func showEmptyTaskDetails() {
        guard let view = view else { return }
        router?.presentNewTaskDetailsScreen(from: view)
    }
    
    func removeTask(_ task: TaskEntity) {
        interactor?.deleteTask(task)
    }
}

extension TaskListPresenter: TaskListInteractorOutputProtocol {
    
    func didAddTask(_ task: TaskEntity) {
        interactor?.retrieveTasks()
    }
    
    func didRemoveTask(_ task: TaskEntity) {
        interactor?.retrieveTasks()
    }
    
    func didRetriveTasks(_ tasks: [TaskEntity]) {
        view?.showTasks(tasks)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
