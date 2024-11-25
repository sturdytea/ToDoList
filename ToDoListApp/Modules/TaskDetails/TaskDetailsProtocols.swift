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
    func showTask(_ task: Task)
}

protocol TaskDetailsPresenterProtocol {
    var view: TaskDetailsViewProtocol? { get set }
    var interactor: TaskDetailsInteractorInputProtocol? { get set }
    var router: TaskDetailsRouterProtocol? { get set }
    func viewDidLoad()
    func editTask(todo: String, desc: String)
}

protocol TaskDetailsInteractorInputProtocol {
    var presenter: TaskDetailsInteractorOutputProtocol? { get set }
    var task: Task? { get set }
    func editTask(todo: String, desc: String)
}

protocol TaskDetailsInteractorOutputProtocol {
    func didEditTask(_ task: Task)
}

protocol TaskDetailsRouterProtocol {
    static func createTaskDetailsModule(with task: Task) -> UIViewController
    func navigateBackToTaskListViewController(from view: TaskDetailsViewProtocol)
}
