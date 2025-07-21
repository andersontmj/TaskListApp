//
//  TaskListViewController.swift
//  TaskListApp
//
//  Created by Anderson on 13/07/25.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    private let viewModel = TaskListViewModel()
    private let floatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIConstants.accentColor
        button.tintColor = .white
        button.layer.cornerRadius = UIConstants.floatButtonSize / 2
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindViewModel()
        viewModel.loadTasks()
        
        setupTableView()
    }
    
    // MARK: - Configurations
    private func setupUI() {
        view.backgroundColor = UIConstants.backgroundColor
        title = "Lista de Tarefas"
        floatButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(floatButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            floatButton.heightAnchor.constraint(equalToConstant: UIConstants.floatButtonSize),
            floatButton.widthAnchor.constraint(equalToConstant: UIConstants.floatButtonSize),
            floatButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -UIConstants.margin * 2),
            floatButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIConstants.margin * 2)
            
        ])
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.accessibilityLabel = "Lista de tarefas"
        tableView.isAccessibilityElement = false
        tableView.backgroundColor = UIConstants.backgroundColor
        tableView.separatorColor = .systemGray2
        tableView.separatorInset.self = .zero
        tableView.tableHeaderView = createHeaderView()
        tableView.tableHeaderView?.frame.size.height = UIConstants.tableHeaderViewHeight
    }
    
    private func bindViewModel() {
        viewModel.onTasksUpdated = { [weak self] tasks in
           guard let self = self else { return }
           let indexPath = IndexPath(row: tasks.count - 1, section: 0)
           self.tableView.insertRows(at: [indexPath], with: .fade)
       }
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.layer.cornerRadius = 8
        headerView.layer.masksToBounds = true
        
        let headerLabel = UILabel()
        headerLabel.text = "Minhas Tarefas"
        headerLabel.font = .systemFont(ofSize: 18, weight: .bold)
        headerLabel.textColor = .white
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: UIConstants.margin),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -UIConstants.margin),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    // MARK: - Actions
    @objc func addTask() {
        let alert = UIAlertController(title: "Nova tarefa", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Digite uma tarefa"
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Adicionar", style: .default) { _ in
            if let title = alert.textFields?.first?.text, !title.isEmpty {
                self.viewModel.addTask(title: title)
            }
        })
        
        present(alert, animated: true)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTasks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        let task = viewModel.task(at: indexPath.row)
        cell.configure(with: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.5,
                       delay: 0.05 * Double(indexPath.row), options: .curveEaseInOut) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}
