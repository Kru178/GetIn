//
//  GIListVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit

protocol GIWordsVCDelegate: class {
    func addWord(listIndex: Int, word: WordModel)
}

class GIListVC: UIViewController {
    
    let tableView = UITableView()
    var dictionaryModel = DictionaryModel()
    
    let center = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        title = "Your Lists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGreen
        
        if dictionaryModel.vocabulary.isEmpty {
        configureEmptyStateView(with: "You have no lists yet.\nStart creating!", in: view)
        } else {
            configureView()
        }
        
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        scheduleNotification()
    }

    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Repetition Time!"
        content.body = "Hey! It's time to repeat something, don't you think?!"
        content.badge = NSNumber(value: 3)
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 11
        dateComponents.minute = 26
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    @objc func addList() {
        var listTitle: String = ""
        
        let alert = UIAlertController(title: "Add New List", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Done", style: .default) { (_) in
            let textField = alert.textFields![0] as UITextField
            guard let text = textField.text else {return}
            
            if !self.dictionaryModel.vocabulary.contains(where: {$0.title == text}) {
                listTitle = text
                let newList = List(title: listTitle)
                self.dictionaryModel.vocabulary.append(newList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.configureView()
                }
            } else {
                let ac = UIAlertController(title: "Name Already Exists", message: "Please choose another name for your new list", preferredStyle: .alert)
                let acAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
                    self.present(alert, animated: true, completion: nil)
                })
                ac.addAction(acAction)
                self.present(ac, animated: true, completion: nil)
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
    
    
    func configureView() {
        
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
    
    func configureEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GIEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

extension GIListVC: UITableViewDataSource, UITableViewDelegate {
    //MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryModel.vocabulary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        let progress = dictionaryModel.vocabulary[indexPath.row].learned
        cell.nameLabel.text = dictionaryModel.vocabulary[indexPath.row].title
        cell.wordsLabel.text = "Words: \(dictionaryModel.vocabulary[indexPath.row].words.count)"
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
        vc.listName = dictionaryModel.vocabulary[indexPath.row].title ?? "default"
        vc.words = dictionaryModel.vocabulary[indexPath.row].words
        vc.delegate = self
        vc.index = indexPath.row
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completed) in
            self!.dictionaryModel.vocabulary.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completed(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completed) in
            
            let ac = UIAlertController(title: "Edit Title", message: "Please enter the new title" , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
                
//                self.dictionaryModel.vocabulary[indexPath.row].title = textf
            }))
            ac.addTextField { (textField) in
                textField.placeholder = "title"
                
            }
            self.present(ac, animated: true, completion: nil)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension GIListVC: GIWordsVCDelegate {
    
    func addWord(listIndex: Int, word: WordModel) {
        dictionaryModel.vocabulary[listIndex].words.append(word)
        tableView.reloadData()
    }
}
