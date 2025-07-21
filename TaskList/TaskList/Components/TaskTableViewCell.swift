//
//  TaskTableViewCell.swift
//  TaskListApp
//
//  Created by Anderson on 14/07/25.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    static let identifier = "TaskTableViewCell"
    
    private let titleLabel = UILabel()
    private let checkMarkImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(titleLabel)
        
        checkMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkMarkImageView)
        
        isAccessibilityElement = true
        accessibilityTraits = .staticText
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkMarkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.margin),
            checkMarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMarkImageView.widthAnchor.constraint(equalToConstant: UIConstants.iconWidth),
            checkMarkImageView.heightAnchor.constraint(equalToConstant: UIConstants.iconHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkMarkImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.margin),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        titleLabel.attributedText = task.isCompleted ? NSAttributedString(string: task.title, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        ) : NSAttributedString(string: task.title)
        accessibilityLabel = "\(task.title), \(task.isCompleted ? "concluída" : "não concluída")"
        titleLabel.textColor = task.isCompleted ? .secondaryLabel : UIConstants.labelColor
        
        checkMarkImageView.image = task.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        checkMarkImageView.tintColor = task.isCompleted ? .systemGreen : .systemGray
    }
}
