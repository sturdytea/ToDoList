//
//
// TaskDetailsProtocols.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

protocol TaskDetailsViewProtocol {
    var presenter: TaskDetailsPresenterProtocol? { get set }
    func showTask(_ task: TaskEntity)
}

protocol TaskDetailsPresenterProtocol {
    var view: TaskDetailsViewProtocol? { get set }
    var listView: TaskListViewProtocol? { get set }
    var interactor: TaskDetailsInteractorInputProtocol? { get set }
    var router: TaskDetailsRouterProtocol? { get set }
    func viewDidLoad()
    func addTask(_ title: String)
    func editTask(todo: String, desc: String)
}

protocol TaskDetailsInteractorInputProtocol {
    var presenter: TaskDetailsInteractorOutputProtocol? { get set }
    var task: TaskEntity? { get set }
    func saveTask(_ title: String)
    func retrieveTasks()
    func editTask(todo: String, desc: String)
}

protocol TaskDetailsInteractorOutputProtocol {
    func didAddTask (_ title: String)
    func didEditTask(_ task: TaskEntity)
    func didRetriveTasks(_ tasks: [TaskEntity])
}

protocol TaskDetailsRouterProtocol {
    static func createTaskDetailsModule(with task: TaskEntity) -> UIViewController
    func navigateBackToTaskListViewController(from view: TaskDetailsViewProtocol)
}
