//
//  GIListVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit
import CoreData

class GIListVC: UIViewController {
    
    let tableView = UITableView()
    
    var container: NSPersistentContainer?
    var dictionary = [ListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your Lists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGreen
        
//        if dictionary.isEmpty {
//        configureEmptyStateView(with: "You have no lists yet.\nStart creating!", in: view)
//        } else {
//            configureView()
//        }
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        
    }
    
    
    @objc func addList() {
        var listTitle: String = ""
        
        let alert = UIAlertController(title: "Add New List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Done", style: .default) { [weak self] (_) in
            
            guard let vc = self else { return }
            
            let textField = alert.textFields![0] as UITextField
            guard let text = textField.text else {return}
            
            if !vc.dictionary.contains(where: {$0.title == text}) {
                listTitle = text
                
                guard let container = vc.container else { return }
                
                let newList = ListModel(context: container.viewContext)
                newList.title = listTitle
                vc.dictionary.append(newList)
                
                DispatchQueue.main.async {
                    
                    do {
                        try container.viewContext.save()
                        
                        
                    } catch {
                        print("cannot save context: addList")
                    }

                    vc.fetchData()
                }
                
            } else {
                let ac = UIAlertController(title: "Name Already Exists", message: "Please choose another name for your new list", preferredStyle: .alert)
                let acAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
                    vc.present(alert, animated: true, completion: nil)
                })
                ac.addAction(acAction)
                vc.present(ac, animated: true, completion: nil)
            }
        }
        
        alert.addTextField { textField in
            textField.placeholder = "List name"
            action.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
                   {_ in
                       // Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
                       let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                       let textIsNotEmpty = textCount > 0
                       action.isEnabled = textIsNotEmpty
               })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    private func configureView() {
        
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseID)
        view.addSubview(tableView)
        

        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GIEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    private func fetchData() {
        guard let container = self.container else {
            return
        }
        do {
            self.dictionary = try container.viewContext.fetch(ListModel.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("fetchData fail: GIListVC")
        }
    }
}

extension GIListVC: UITableViewDataSource, UITableViewDelegate {
    //MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        let list = dictionary[indexPath.row]
        
        cell.nameLabel.text = list.title
        cell.wordsLabel.text = "Words: \(list.words?.count ?? 0)"
        
        let progress = list.learned
        
        cell.progressLabel.text = "Learned: \(progress) %"
        
        switch progress {
        case 0...30:
            cell.progressLabel.backgroundColor = .secondarySystemBackground
        case 31...70:
            cell.progressLabel.backgroundColor = .systemYellow
        default:
            cell.progressLabel.backgroundColor = .systemGreen
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = GIWordsVC()
        
        vc.listName = dictionary[indexPath.row].title ?? "default"
        vc.list = dictionary[indexPath.row]
        vc.container = container
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completed) in
            
            guard let listToRemove = self?.dictionary[indexPath.row] else { return }
            self?.container?.viewContext.delete(listToRemove)
            
            do {
                try self?.container?.viewContext.save()
            } catch {
                print("save when delete error")
            }
            
            self?.dictionary.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completed(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
}
