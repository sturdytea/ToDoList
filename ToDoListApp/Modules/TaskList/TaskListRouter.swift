//
//
// TaskListRouter.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class TaskListRouter: TaskListRouterProtocol {
    static func createTaskListModule() -> UIViewController {
        let taskListViewController = TaskListViewController()
        let navigationController = UINavigationController(rootViewController: taskListViewController)
        
        let presenter = TaskListPresenter()
        let interactor = TaskListInteractor()
        let router = TaskListRouter()
        
        taskListViewController.presenter = presenter
        presenter.view = taskListViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navigationController
    }
    
    public func presentTaskDetailsScreen(from view: TaskListViewProtocol, for task: Task) {
        let taskDetailsViewController = TaskDetailsRouter.createTaskDetailsModule(with: task)
        
        guard let view = view as? UIViewController else {
            fatalError("TaskListRouter: Invalid View Protocol")
        }
        
        view.navigationController?.pushViewController(taskDetailsViewController, animated: true)
    }
}
