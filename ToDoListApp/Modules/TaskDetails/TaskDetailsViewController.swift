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

final class TaskDetailsViewController: UIViewController, UITextFieldDelegate {

    var presenter: TaskDetailsPresenterProtocol?
    
    private lazy var taskDetailsView = TaskDetailsView()
    override func loadView() {
        view = taskDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        setupDelegates()
    }
    
    private func setupDelegates() {
        taskDetailsView.title.delegate = self
        taskDetailsView.desc.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.taskDetailsView.title.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let title = taskDetailsView.title.text,
              !title.isEmpty,
              title != "" else { return }
        presenter?.addTask(title)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == taskDetailsView.title {
            guard let inputText = textField.text,
                  !inputText.isEmpty,
                  !inputText.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            presenter?.editTask(todo: inputText, desc: "")
        }
        
        if textField == taskDetailsView.desc {
            guard let inputText = taskDetailsView.desc.text else { return }
            presenter?.editTask(todo: "", desc: inputText)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension TaskDetailsViewController: TaskDetailsViewProtocol {
    
    func showTask(_ task: TaskEntity) {
        taskDetailsView.title.text = task.todo
        taskDetailsView.desc.text = task.desc
    }
}
