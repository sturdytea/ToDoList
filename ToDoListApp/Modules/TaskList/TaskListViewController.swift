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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
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

extension TaskListViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = taskListView.tableView.indexPathForRow(at: location) else {
            return nil
        }
        
        let task = tasks[indexPath.row]
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: {
            self.createTaskPreview(for: task)
        }, actionProvider: { _ in
            self.createTaskMenu(for: task, at: indexPath)
        })
    }
    
    private func createTaskPreview(for task: TaskEntity) -> UIViewController {
        let preview = UIViewController()
        preview.view.backgroundColor = .customGray
        preview.view.layer.cornerRadius = 12
        
        let cell = TaskListTableViewCell()
        
        let cellHeight = getCellHeight(for: task)
        preview.preferredContentSize = CGSize(width: self.view.bounds.width - 32, height: cellHeight)
        
        lazy var title: UILabel = {
            let label = cell.title
            label.text = task.todo
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var desc: UILabel = {
            let label = cell.desc
            label.text = task.desc
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var date: UILabel = {
            let label = cell.date
            label.text = cell.formatDate(task.date ?? Date())
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        preview.view.addSubview(title)
        preview.view.addSubview(desc)
        preview.view.addSubview(date)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: preview.view.centerXAnchor),
            title.topAnchor.constraint(equalTo: preview.view.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: preview.view.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: preview.view.trailingAnchor, constant: -16),
            title.heightAnchor.constraint(equalToConstant: 22),
            
            desc.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            desc.trailingAnchor.constraint(equalTo: preview.view.trailingAnchor),
            
            date.leadingAnchor.constraint(equalTo: desc.leadingAnchor),
            date.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 4),
            date.trailingAnchor.constraint(equalTo: preview.view.trailingAnchor),
            date.heightAnchor.constraint(equalToConstant: 16),
            date.bottomAnchor.constraint(equalTo: preview.view.bottomAnchor, constant: -16)
        ])
        
        return preview
    }
    
    private func getCellHeight(for task: TaskEntity) -> CGFloat {
        guard let row = (isSearching ? filteredTasks : tasks).firstIndex(where: { $0 == task }) else {
            return 44
        }
        
        let indexPath = IndexPath(row: row, section: 0)
        
        let cellRect = self.taskListView.tableView.rectForRow(at: indexPath)
        return cellRect.height
    }
    
    private func createTaskMenu(for task: TaskEntity, at indexPath: IndexPath) -> UIMenu {
        let editAction = UIAction(title: LocalizedContent.MenuOption.edit, image: UIImage(systemName: "square.and.pencil")) { _ in
            self.presenter?.showTaskDetails(task)
        }
        
        let shareAction = UIAction(title: LocalizedContent.MenuOption.share, image: UIImage(systemName: "square.and.arrow.up")) { _ in
            let activityController = UIActivityViewController(activityItems: [task.todo ?? "", task.desc ?? ""], applicationActivities: nil)
            self.present(activityController, animated: true)
        }
        
        let deleteAction = UIAction(title: LocalizedContent.MenuOption.delete, image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            self.presenter?.removeTask(task)
            self.tasks.remove(at: indexPath.row)
            self.taskListView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
    }
    
}
