//
//
// TaskListProtocols.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

protocol TaskListViewProtocol {
    var presenter: TaskListPresenterProtocol? { get set }
    func showTasks(_ tasks: [TaskEntity])
    func showErrorMessage(_ message: String)
}

protocol TaskListPresenterProtocol {
    var view: TaskListViewProtocol? { get set }
    var interactor: TaskListInteractorInputProtocol? { get set }
    var router: TaskListRouterProtocol? { get set }
    func loadTasks() async
    func viewWillAppear()
    func showTaskDetails(_ task: TaskEntity)
    func showEmptyTaskDetails()
    func removeTask(_ task: TaskEntity)
}

protocol TaskListInteractorInputProtocol {
    var presenter: TaskListInteractorOutputProtocol? { get set }
    func retrieveTasks()
    func fetchTasks() async throws -> [TaskEntity]
    func deleteTask(_ task: TaskEntity)
}

protocol TaskListInteractorOutputProtocol {
    func didAddTask(_ task: TaskEntity)
    func didRemoveTask(_ task: TaskEntity)
    func didRetriveTasks(_ tasks: [TaskEntity])
    func onError(message: String)
}

protocol TaskListRouterProtocol {
    static func createTaskListModule() -> UIViewController
    func presentTaskDetailsScreen(from view: TaskListViewProtocol, for task: TaskEntity)
    func presentNewTaskDetailsScreen(from view: TaskListViewProtocol)
}

protocol TaskListViewDelegate {
    func didTapCreateNewTask()
}
