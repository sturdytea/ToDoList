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
    
    func showTaskDetails(_ task: TaskModel) {
        guard let view = view else { return }
        router?.presentTaskDetailsScreen(from: view, for: task)
    }
    
    func showEmptyTaskDetails() {
        guard let view = view else { return }
        router?.presentNewTaskDetailsScreen(from: view)
    }
    
    func addTask(_ task: TaskModel) {
        interactor?.saveTask(task)
    }
    
    func removeTask(_ task: TaskModel) {
        interactor?.deleteTask(task)
    }
}

extension TaskListPresenter: TaskListInteractorOutputProtocol {
    
    func didAddTask(_ task: TaskModel) {
        interactor?.retrieveTasks()
    }
    
    func didRemoveTask(_ task: TaskModel) {
        interactor?.retrieveTasks()
    }
    
    func didRetriveTasks(_ tasks: [TaskModel]) {
        view?.showTasks(tasks)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
