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

protocol CheckboxDelegate {
    func checkboxTapped(isChecked: Bool, checkbox: Checkbox)
}

final class Checkbox: UIButton {
    
    var isChecked = false
    private let checkbox = UIImageView()
    var delegate: CheckboxDelegate?
    
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
            checkbox.heightAnchor.constraint(equalToConstant: 28),
            checkbox.widthAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func checkTask() {
        toggle()
        delegate?.checkboxTapped(isChecked: isChecked, checkbox: self)
    }
    
    private func toggle() {
        self.isChecked.toggle()
        checkbox.image = UIImage(systemName: isChecked ? "checkmark.circle" : "circle")
        checkbox.tintColor = isChecked ? .accent : .stroke
    }
}
