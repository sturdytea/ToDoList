//
//
// TaskDetailsRouter.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class TaskDetailsRouter: TaskDetailsRouterProtocol {
    
    static func createTaskDetailsModule(with task: TaskEntity) -> UIViewController {
        let taskDetailsViewController = TaskDetailsViewController()
        let presenter = TaskDetailsPresenter()
        let interactor = TaskDetailsInteractor()
        let router = TaskDetailsRouter()
        
        taskDetailsViewController.presenter = presenter
        presenter.view = taskDetailsViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.task = task
        interactor.presenter = presenter
        
        return taskDetailsViewController
    }
    
    static func createTaskDetailsModule() -> UIViewController {
        let taskDetailsViewController = TaskDetailsViewController()
        let presenter = TaskDetailsPresenter()
        let interactor = TaskDetailsInteractor()
        let router = TaskDetailsRouter()
        
        taskDetailsViewController.presenter = presenter
        presenter.view = taskDetailsViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return taskDetailsViewController
    }

    
    func navigateBackToTaskListViewController(from view: any TaskDetailsViewProtocol) {
        guard let view = view as? UIViewController else {
            fatalError("TaskDetailsRouter: Invalid view protocol type")
        }
        view.navigationController?.popViewController(animated: true)
    }
    
    
}
