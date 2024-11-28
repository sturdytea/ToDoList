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

final class TaskDetailsViewController: UIViewController, UITextViewDelegate {

    var presenter: TaskDetailsPresenterProtocol?
    private var initialTitle: String?
    private var initialDescription: String?
    
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
        
        initialTitle = taskDetailsView.title.text
        initialDescription = taskDetailsView.desc.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if taskDetailsView.title.text != LocalizedContent.Placeholder.title && !taskDetailsView.title.text.isEmpty {
            taskDetailsView.title.textColor = .textPrimary
        }
        
        if taskDetailsView.desc.text == LocalizedContent.Placeholder.desc {
            taskDetailsView.desc.textColor = .textSecondary
        } else {
            taskDetailsView.desc.textColor = .textPrimary
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let title = taskDetailsView.title.text,
              !title.isEmpty,
           title != initialTitle,
           title != LocalizedContent.Placeholder.title,
              !title.trimmingCharacters(in: .whitespaces).isEmpty {
            presenter?.addTask(title)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == taskDetailsView.title {
            if textView.text == LocalizedContent.Placeholder.title {
                textView.text = ""
                textView.textColor = .textPrimary
            }
        }
        
        if textView == taskDetailsView.desc {
            if textView.text == LocalizedContent.Placeholder.desc {
                textView.text = ""
                textView.textColor = .textPrimary
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == taskDetailsView.title {
            if textView.text.isEmpty {
                textView.text = LocalizedContent.Placeholder.title
                textView.textColor = .textSecondary
                return
            }
            
            if let inputText = textView.text,
               !inputText.isEmpty,
               !inputText.trimmingCharacters(in: .whitespaces).isEmpty,
               inputText != LocalizedContent.Placeholder.title {
                presenter?.editTask(todo: inputText, desc: "")
            }
        }
        
        if textView == taskDetailsView.desc {
            if textView.text.isEmpty {
                textView.text = LocalizedContent.Placeholder.desc
                textView.textColor = .textSecondary
                return
            }
            
            if let inputText = textView.text,
               !inputText.isEmpty,
               !inputText.trimmingCharacters(in: .whitespaces).isEmpty,
               inputText != LocalizedContent.Placeholder.desc {
                presenter?.editTask(todo: "", desc: inputText)
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension TaskDetailsViewController: TaskDetailsViewProtocol {
    
    func showTask(_ task: TaskEntity) {
        DispatchQueue.main.async {
            self.taskDetailsView.configureView(task.todo ?? LocalizedContent.Placeholder.title, task.desc ?? LocalizedContent.Placeholder.desc, task.date ?? Date())
            
            self.taskDetailsView.configureTextColors(title: self.taskDetailsView.title.text != LocalizedContent.Placeholder.title ? .textPrimary : .textSecondary, desc: self.taskDetailsView.desc.text != LocalizedContent.Placeholder.desc ? .textPrimary : .textSecondary)
        }
        
        initialTitle = task.todo
        initialDescription = task.desc
    }
}
