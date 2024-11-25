//
//
// TaskDetailsViewController.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class TaskDetailsViewController: UIViewController {

    var presenter: TaskDetailsPresenterProtocol?
    
    private lazy var taskDetailsView = TaskDetailsView()
    override func loadView() {
        view = taskDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        taskDetailsView.title.becomeFirstResponder()
    }
}

extension TaskDetailsViewController: TaskDetailsViewProtocol {
    
    func showTask(_ task: Task) {
        taskDetailsView.title.text = task.todo
        taskDetailsView.desc.text = task.desc
    }
}