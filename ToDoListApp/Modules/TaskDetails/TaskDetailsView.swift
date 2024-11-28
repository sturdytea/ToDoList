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
    
    private(set) lazy var title: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 34, weight: .bold)
        textView.isEditable = true
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var desc: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isEditable = true
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .textSecondary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBackground
        setupView()
        setupConstraints()
    }
    
    private lazy var dateFormatter = DateFormatter()
    
    func configureView(_ title: String, _ desc: String, _ date: Date) {
        self.title.text = title
        self.desc.text = desc
        dateFormatter.dateFormat = "dd/MM/yy"
        self.date.text = dateFormatter.string(from: date)
    }
    
    func configureTextColors(title: UIColor, desc: UIColor) {
        self.title.textColor = title
        self.desc.textColor = desc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(title)
        addSubview(desc)
        addSubview(date)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            date.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: 8),
            date.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            desc.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 8),
            desc.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            desc.trailingAnchor.constraint(equalTo: title.trailingAnchor),
        ])
    }
}
