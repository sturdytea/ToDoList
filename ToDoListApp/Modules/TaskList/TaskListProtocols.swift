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
    func showTasks(_ tasks: [Task])
    func showErrorMessage(_ message: String)
}

protocol TaskListPresenterProtocol {
    var view: TaskListViewProtocol? { get set }
    var interactor: TaskListInteractorInputProtocol? { get set }
    var router: TaskListRouterProtocol? { get set }
    func viewWillAppear()
    func showTaskDetails(_ task: Task)
    func addTask(_ task: Task)
    func removeTask(_ task: Task)
}

protocol TaskListInteractorInputProtocol {
    var presenter: TaskListInteractorOutputProtocol? { get set }
    func retrieveTasks()
    func saveTask(_ task: Task)
    func deleteTask(_ task: Task)
}

protocol TaskListInteractorOutputProtocol {
    func didAddTask(_ task: Task)
    func didRemoveTask(_ task: Task)
    func didRetriveTasks(_ tasks: [Task])
    func onError(message: String)
}

protocol TaskListRouterProtocol {
    static func createTaskListModule() -> UIViewController
    func presentTaskDetailsScreen(from view: TaskListViewProtocol, for task: Task)
}
