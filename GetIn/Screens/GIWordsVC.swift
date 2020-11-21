//
//  GIWordsVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit

class GIWordsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var listName: String = ""
    var words = [Word]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = listName
        view.backgroundColor = .systemTeal
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
    }
    
    
    @objc func addWord() {
        var wordTitle: String?
        var wordTranslation: String?
//        var newWord: Word?
        
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
            if textField1.text != "" {
                wordTitle = textField1.text
//                newWord?.title = wordTitle!
            } else {
                print("TF 1 is Empty...")
            }
            
            if textField2.text != "" {
                wordTranslation = textField2.text
//                newWord?.translation = wordTranslation!
            } else {
                print("TF 2 is Empty...")
            }
            
            let newWord = Word(title: wordTitle!, translation: wordTranslation!)
            print(newWord)
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
//            ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "wordCell")
        
        tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        
//        if let wrds = words  {
            cell.textLabel?.text = words[indexPath.row].title
            cell.detailTextLabel?.text = words[indexPath.row].translation
//        } else {
//            cell.textLabel?.text = "word"
//            cell.detailTextLabel?.text = "translation"
//        }
        return cell
    }
    
    
}
