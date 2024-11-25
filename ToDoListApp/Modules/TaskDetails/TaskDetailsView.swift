//
//
// TaskDetailsView.swift
// ToDoListApp
//
// Created by sturdytea on 24.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class TaskDetailsView: UIView {
    
    private(set) lazy var title: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Title"
        textField.textAlignment = .left
        textField.textColor = .textPrimary
        textField.font = .systemFont(ofSize: 34, weight: .bold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private(set) lazy var desc: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Task description here..."
        textField.textAlignment = .left
        textField.textColor = .textPrimary
        textField.font = .systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBackground
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(title)
        addSubview(desc)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            desc.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            desc.trailingAnchor.constraint(equalTo: title.trailingAnchor),
        ])
    }
}
