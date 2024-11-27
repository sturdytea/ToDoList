//
//
// TaskListViewController.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class TaskListViewController: UITableViewController {
    
    var presenter: TaskListPresenterProtocol?
    var tasks: [TaskEntity] = []
    
    private lazy var taskListView = TaskListView()
    override func loadView() {
        view = taskListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await presenter?.loadTasks()
        }
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    private func setupView() {
        taskListView.delegate = self
        taskListView.tableView.delegate = self
        taskListView.tableView.dataSource = self
        
        title = LocalizedContent.largeTitle
        
        if let navigationController = navigationController {
            let largeTitleFont = UIFont.systemFont(ofSize: 34, weight: .bold)
            
            navigationController.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.font: largeTitleFont,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            navigationController.navigationBar.prefersLargeTitles = true
        }
        taskListView.configureToolBar(amount: tasks.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Task count \(tasks.count)")
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListTableViewCell.identifier, for: indexPath) as! TaskListTableViewCell
        let task = tasks[indexPath.row]
        cell.configureCell(task.todo ?? "", task.desc ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        presenter?.showTaskDetails(task)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskItem = tasks[indexPath.row]
            presenter?.removeTask(taskItem)
        }
    }
}

extension TaskListViewController: TaskListViewProtocol {
    func showTasks(_ tasks: [TaskEntity]) {
        self.tasks = tasks
        DispatchQueue.main.async {
            self.taskListView.tableView.reloadData()
        }
    }
    
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
}

extension TaskListViewController: TaskListViewDelegate {
    func didTapCreateNewTask() {
        presenter?.showEmptyTaskDetails()
    }
}
