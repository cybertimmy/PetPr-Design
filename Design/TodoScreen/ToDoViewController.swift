import UIKit
import RealmSwift

final class ToDoViewController: UIViewController {
    
    private let realm = try! Realm()
    private let taskRealm: TaskRealm
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.backgroundColor = UIColor.darkBGColor()
        return tableView
    }()
    
    init() {
        self.taskRealm = TaskRealm()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        taskRealm.tasks = realm.objects(TaskRealm.self)
        setupTitle()
        setupTableView()
        createRightBarButtonItem()
        setupAppearance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTitle() {
        navigationItem.title = "ToDo"
    }
    
    private func setupAppearance() {
        view.addSubviews(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ToDoViewController {
    private func createRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func didTapPressed() {
        let alertController = UIAlertController(title: "Add your task", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Create new task"
        }
        let actionAddTask = UIAlertAction(title: "Add", style: .default) { _ in
            if let taskName = alertController.textFields?.first?.text, !taskName.isEmpty {
                let taskRealm = TaskRealm()
                taskRealm.name = taskName
                try! self.realm.write({
                    self.realm.add(taskRealm)
                })
                self.tableView.reloadData()
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(actionAddTask)
        alertController.addAction(actionCancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskRealm.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = taskRealm.tasks[indexPath.row].name
        cell.accessoryType =  taskRealm.tasks[indexPath.row].isCompleted ? .checkmark : .none
        cell.backgroundColor = UIColor.darkBGColor()
        cell.textLabel?.textColor = UIColor.brownColor()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskRealm.tasks[indexPath.row]
        try! realm.write({
            task.isCompleted.toggle()
            if task.isCompleted  {
                realm.delete(task)
            }
        })
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskRealm.tasks[indexPath.row]
            try! realm.write({
                realm.delete(task)
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
