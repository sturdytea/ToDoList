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
    func showTask(_ task: TaskModel)
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
    var task: TaskModel? { get set }
    func editTask(todo: String, desc: String)
}

protocol TaskDetailsInteractorOutputProtocol {
    func didEditTask(_ task: TaskModel)
}

protocol TaskDetailsRouterProtocol {
    static func createTaskDetailsModule(with task: TaskModel) -> UIViewController
    func navigateBackToTaskListViewController(from view: TaskDetailsViewProtocol)
}
