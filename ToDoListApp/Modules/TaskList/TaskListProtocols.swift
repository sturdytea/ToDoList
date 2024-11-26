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
    func showTasks(_ tasks: [TaskModel])
    func showErrorMessage(_ message: String)
}

protocol TaskListPresenterProtocol {
    var view: TaskListViewProtocol? { get set }
    var interactor: TaskListInteractorInputProtocol? { get set }
    var router: TaskListRouterProtocol? { get set }
    func loadTasks() async
    func viewWillAppear()
    func showTaskDetails(_ task: TaskModel)
    func showEmptyTaskDetails()
    func addTask(_ task: TaskModel)
    func removeTask(_ task: TaskModel)
}

protocol TaskListInteractorInputProtocol {
    var presenter: TaskListInteractorOutputProtocol? { get set }
    func retrieveTasks()
    func fetchTasks() async throws -> [TaskModel]
    func saveTask(_ task: TaskModel)
    func deleteTask(_ task: TaskModel)
}

protocol TaskListInteractorOutputProtocol {
    func didAddTask(_ task: TaskModel)
    func didRemoveTask(_ task: TaskModel)
    func didRetriveTasks(_ tasks: [TaskModel])
    func onError(message: String)
}

protocol TaskListRouterProtocol {
    static func createTaskListModule() -> UIViewController
    func presentTaskDetailsScreen(from view: TaskListViewProtocol, for task: TaskModel)
    func presentNewTaskDetailsScreen(from view: TaskListViewProtocol)
}

protocol TaskListViewDelegate {
    func didTapCreateNewTask()
}
