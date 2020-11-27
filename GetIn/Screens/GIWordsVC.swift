//
//  GIWordsVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit

class GIWordsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: GIListVCDelegate?
    
    var index = 0
    
    private let tableView = UITableView()
    
    var listName = "default"
    var words = [WordModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = listName
        view.backgroundColor = .systemTeal
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
    }
    
    
    @objc func addWord() {
        
        let alert = UIAlertController(title: "Add New Word", message: "and translation :)", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "word"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "translation"
        }
        
        let action = UIAlertAction(title: "Done", style: .default) { (_) in
            let textField1 = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            
// MARK: FIX it later: activate "done" button if textFields is not empty
            
            guard let word = textField1.text else { return }
            guard let translation = textField2.text else { return }
            
            let newWord = WordModel(word: word, translation: translation)
            
            self.delegate?.addWord(listIndex: self.index, word: newWord)
            self.words.append(newWord)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "wordCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "wordCell")
        
        tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        
        cell.textLabel?.text = words[indexPath.row].word
        cell.detailTextLabel?.text = words[indexPath.row].translation

        return cell
    }
}
