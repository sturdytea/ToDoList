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

final class TaskListViewController: UITableViewController, UISearchResultsUpdating {
    
    var presenter: TaskListPresenterProtocol?
    var tasks: [TaskEntity] = [] {
        didSet {
            taskListView.tableView.reloadData()
        }
    }
    
    private var filteredTasks: [TaskEntity] = []
    
    private var isSearching: Bool {
        return !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = LocalizedContent.Placeholder.searchBar
        controller.searchBar.autocapitalizationType = .none
        return controller
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            navigationItem.searchController = searchController
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Task count \(isSearching ? filteredTasks.count : tasks.count)")
        return isSearching ? filteredTasks.count : tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListTableViewCell.identifier, for: indexPath) as! TaskListTableViewCell
        let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        cell.configureCell(task.todo ?? "", task.desc ?? "", task.date ?? Date(), isChecked: task.isCompleted)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        presenter?.showTaskDetails(task)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskItem = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
            presenter?.removeTask(taskItem)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.lowercased(), !query.isEmpty else {
            filteredTasks = []
            taskListView.tableView.reloadData()
            return
        }
        
        filteredTasks = tasks.filter { task in
            (task.todo?.lowercased().contains(query) ?? false) ||
            (task.desc?.lowercased().contains(query) ?? false)
        }
        taskListView.tableView.reloadData()
    }
}

extension TaskListViewController: TaskListViewProtocol {
    func showTasks(_ tasks: [TaskEntity]) {
        self.tasks = tasks
    }
    
    func updateTaskCount(amount: Int) {
        DispatchQueue.main.async {
            let counter: String
            switch amount {
            case 1:
                counter = LocalizedContent.Counter.oneTask
            case 2...4:
                counter = LocalizedContent.Counter.twoToFourTasks
            default:
                counter = LocalizedContent.Counter.multipleTasks
            }
            self.taskListView.counter.text = "\(amount) \(counter)"
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
