//
//
// TaskListView.swift
// ToDoListApp
//
// Created by sturdytea on 24.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class TaskListView: UIView {
    
    var delegate: TaskListViewDelegate?
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskListTableViewCell.self, forCellReuseIdentifier: TaskListTableViewCell.identifier)
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let barHeight: CGFloat = 88
    
    lazy var counter: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar(frame: .init(x: 0, y: UIScreen.main.bounds.height - 72, width: UIScreen.main.bounds.width, height: barHeight))
        toolbar.backgroundColor = .customGray
        toolbar.compactAppearance = .none
        toolbar.tintColor = .accent
        toolbar.contentMode = .scaleToFill
        toolbar.sizeToFit()
        
        let spaceArea: UIBarButtonItem = .init(systemItem: .flexibleSpace)
        let counterContainer: UIBarButtonItem = .init(customView: counter)
        let newTask: UIBarButtonItem = .init(image: UIImage(systemName: "square.and.pencil"), style: .done, target: self, action: #selector(createNewTaskTapped))
        
        toolbar.setItems([spaceArea, counterContainer, spaceArea, newTask], animated: false)
        toolbar.isUserInteractionEnabled = true
        return toolbar
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
        clipsToBounds = true
        addSubview(tableView)
        addSubview(toolBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: toolBar.topAnchor),
            
            toolBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension TaskListView {
    
    @objc func createNewTaskTapped() {
        delegate?.didTapCreateNewTask()
    }
}
