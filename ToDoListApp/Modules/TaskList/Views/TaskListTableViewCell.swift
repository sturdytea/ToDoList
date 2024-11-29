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

final class TaskListTableViewCell: UITableViewCell, CheckboxDelegate {
    
    static let identifier = "TaskListTableViewCell"
    
    private lazy var checkbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.delegate = self
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var desc: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .textSecondary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func configureCell(_ title: String, _ desc: String, _ date: Date, isChecked: Bool) {
        self.title.text = title
        self.desc.text = desc
        self.date.text = formatDate(date)
        setupViews()
        setupConstraints()
    }
    
    public func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
    
    private func setupViews() {
        addSubview(checkbox)
        addSubview(title)
        addSubview(desc)
        addSubview(date)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkbox.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 28),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            title.heightAnchor.constraint(equalToConstant: 22),
            
            desc.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            desc.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            date.leadingAnchor.constraint(equalTo: desc.leadingAnchor),
            date.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 4),
            date.trailingAnchor.constraint(equalTo: trailingAnchor),
            date.heightAnchor.constraint(equalToConstant: 16),
            date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func checkboxTapped(isChecked: Bool, checkbox: Checkbox) {
        if isChecked {
            let attributedString = NSAttributedString.init(string: title.text ?? "", attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ])
            title.attributedText = attributedString
        } else {
            title.attributedText = NSAttributedString(string: title.text ?? "")
        }
        
        title.textColor = isChecked ? .textSecondary : .textPrimary
        desc.textColor = isChecked ? .textSecondary : .textPrimary
    }
}
