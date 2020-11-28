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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your Lists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        navigationController?.navigationBar.prefersLargeTitles = true
       
        configureView()
    }
    
    
    @objc func addList() {
        var listTitle: String = ""
        
        let alert = UIAlertController(title: "Add New List", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "list"
        }
        
        let action = UIAlertAction(title: "Done", style: .default) { (_) in
            let textField = alert.textFields![0] as UITextField
            guard let text = textField.text else {return}
            if textField.text != "" {
                listTitle = text
            } else {
                print("TF is Empty...")
                return
            }
            
            let newList = List(title: listTitle)
            print(newList.title)
            self.dictionaryModel.vocabulary.append(newList)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func configureView() {
        
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        //Add learn button
        let learnButton = UIButton(type: .system)
        learnButton.layer.cornerRadius = 12
        learnButton.backgroundColor = .gray
        learnButton.tintColor = .white
        learnButton.translatesAutoresizingMaskIntoConstraints = false
        learnButton.setTitle("LEARN WORDS", for: .normal)
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
        view.addSubview(learnButton)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            learnButton.heightAnchor.constraint(equalToConstant: 50),
            learnButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            learnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            learnButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -5),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: learnButton.topAnchor),
        ])
    }
    
    // learnButton tapped
    @objc func learnButtonTapped() {
        
    }
}

extension GIListVC: UITableViewDataSource, UITableViewDelegate {
    //MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryModel.vocabulary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator //?
        cell.textLabel?.text = dictionaryModel.vocabulary[indexPath.row].title
        cell.detailTextLabel?.text = "Words: \(dictionaryModel.vocabulary[indexPath.row].words.count), learned: \(dictionaryModel.vocabulary[indexPath.row].learned) %"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = GIWordsVC()
        vc.listName = dictionaryModel.vocabulary[indexPath.row].title
        vc.words = dictionaryModel.vocabulary[indexPath.row].words
        vc.delegate = self
        vc.index = indexPath.row
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GIListVC: GIWordsVCDelegate {
    
    func addWord(listIndex: Int, word: WordModel) {
        dictionaryModel.vocabulary[listIndex].words.append(word)
        tableView.reloadData()
    }
}
