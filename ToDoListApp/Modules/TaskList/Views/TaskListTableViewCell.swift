//
//
// TaskListTableViewCell.swift
// ToDoListApp
//
// Created by sturdytea on 24.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class TaskListTableViewCell: UITableViewCell {
    
    static let identifier = "TaskListTableViewCell"
    
    private lazy var checkbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.textColor = checkbox.isChecked ? .textSecondary : .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var desc: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = checkbox.isChecked ? .textSecondary : .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func configureCell(_ title: String, _ desc: String) {
        self.title.text = title
        self.desc.text = desc
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(checkbox)
        contentView.addSubview(title)
        contentView.addSubview(desc)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkbox.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            title.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor),
            title.topAnchor.constraint(equalTo: checkbox.topAnchor),
            
            desc.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            desc.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
