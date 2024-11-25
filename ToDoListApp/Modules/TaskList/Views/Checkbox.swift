//
//
// Checkbox.swift
// ToDoListApp
//
// Created by sturdytea on 24.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class Checkbox: UIButton {
    
    var isChecked = false
    private let checkbox = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        checkbox.contentMode = .scaleAspectFit
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.image = UIImage(systemName: isChecked ? "checkmark.circle" : "circle")
        checkbox.tintColor = .stroke

        let checkTaskGesture = UITapGestureRecognizer(target: self, action: #selector(checkTask))
        
        addSubview(checkbox)
        addGestureRecognizer(checkTaskGesture)
        NSLayoutConstraint.activate([
            checkbox.heightAnchor.constraint(equalToConstant: 24),
            checkbox.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func checkTask() {
        toggle()
    }
    
    func toggle() {
        self.isChecked.toggle()
        checkbox.image = UIImage(systemName: isChecked ? "checkmark.circle" : "circle")
        checkbox.tintColor = isChecked ? .accent : .stroke
    }
}
