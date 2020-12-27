//
//  GIWordsVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit
import CoreData

class GIWordsVC: UIViewController {
    
    var index = 0
    
    private let tableView = UITableView()
    
    var listName = "default"
    var list = ListModel()
    var container : NSPersistentContainer?
    private var words : [WordModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = listName
        view.backgroundColor = .systemTeal
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGreen
        
        
        
        words = list.words?.allObjects as? [WordModel]
        
//        if let words = self.words {
//            if words.count == 0 {
//            configureEmptyStateView(with: "No words here.\nAdd some :)", in: view)
//            } else {
//                configureTableView()
//            }
//        }
        configureTableView()
        
    }
    
    
    @objc func addWord() {
        
        let alert = UIAlertController(title: "Add New Word", message: "and translation :)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Done", style: .default) { (_) in
            let textField1 = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField

            guard let word = textField1.text else { return }
            guard let translation = textField2.text else { return }
            
            guard let words = self.words else { return }
            guard let container = self.container else { return }
            
            if !words.contains(where: {$0.word?.lowercased() == word.lowercased()}) {
                let newWord = WordModel(context: container.viewContext)
                newWord.word = word
                newWord.translation = translation
                newWord.inList = self.list
                
                self.words?.append(newWord)
                
                DispatchQueue.main.async {
                    
                    do {
                        try container.viewContext.save()
                        
                    } catch {
                        print("cannot save context: addWord")
                    }
                    self.tableView.reloadData()
                    
                }
            } else {
                let ac = UIAlertController(title: "Word Already Exists", message: "You already have this word on your list.\nMaybe you should test yourself more often? 👀", preferredStyle: .alert)
                let acAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
                    self.present(alert, animated: true, completion: nil)
                })
                ac.addAction(acAction)
                self.present(ac, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Word"
            action.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
                   {_ in
                       // Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
                       let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                       let textIsNotEmpty = textCount > 0
                       action.isEnabled = textIsNotEmpty
               })
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Translation"
            action.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
                   {_ in
                       // Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
                       let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                       let textIsNotEmpty = textCount > 0
                       action.isEnabled = textIsNotEmpty
               })
        }
        
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func configureEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GIEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.reuseID)
    }
    
//    private func fetchData() {
//
//        guard let container = container else { return }
//
//        do {
//            self.words = try container.viewContext.fetch(WordModel.fetchRequest())
//
//        } catch {
//            print("cannot read context")
//        }
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
}

extension GIWordsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let words = self.words {
            return words.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.reuseID, for: indexPath) as! WordCell
        
        if let words = self.words {
            cell.wordLabel.text = words[indexPath.row].word
            if words[indexPath.row].translation == "" {
                cell.translationLabel.text = "Add translation here"
            } else {
            cell.translationLabel.text = words[indexPath.row].translation
            }
            print(words[indexPath.row].exp)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completed) in
            
            guard let vc = self else { return }
            
            guard let wordToRemove = vc.words?[indexPath.row] else { return }
            vc.container?.viewContext.delete(wordToRemove)
            
            do {
                try self?.container?.viewContext.save()
            } catch {
                print("save when delete error")
            }
            
            vc.words?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            completed(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completed) in
            
        }
        action.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [action])
    }
}
