//
//  GIListVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit

class GIListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
//    let tableView = UITableView()
    var lists = [List]()
    
    var collectionView: UICollectionView!
    
    var list1 = List(title: "English", words: nil)
    var list2 = List(title: "French", words: nil)
    
    var word1 = Word(title: "hello", translation: "privet")
    var word2 = Word(title: "bye-bye", translation: "poka")
    
    
    override func loadView() {
        super.loadView()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let words = [word1, word2]
        
        list1.words = words
        
        lists.append(list1)
        lists.append(list2)
        
        title = "Your Lists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBlue
//        configureTableView()
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            
            let newList = List(title: listTitle, words: [])
            print(newList.title)
            self.lists.append(newList)
            self.collectionView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
//    func configureTableView() {
//        view.addSubview(tableView)
//
//        tableView.frame = view.bounds
//        tableView.rowHeight = 80
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.reloadData()
//    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundView = UIView(frame: CGRect.zero)
        collectionView.backgroundView?.backgroundColor = .secondarySystemBackground
        
        
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: ListViewCell.reuseID)
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return lists.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//
//        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        cell.accessoryType = .disclosureIndicator
//        cell.textLabel?.text = lists[indexPath.row].title
//        cell.detailTextLabel?.text = "Words: \(lists[indexPath.row].words?.count ?? 0)"
//
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let vc = GIWordsVC()
//        vc.listName = lists[indexPath.row].title
//        vc.words = lists[indexPath.row].words ?? []
//
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListViewCell.reuseID, for: indexPath) as! ListViewCell
        
        
        cell.listTitleLabel.text = lists[indexPath.row].title
        cell.wordsCountLabel.text = "Words: \(lists[indexPath.row].words?.count ?? 0)"
        if lists[indexPath.row].title == "English" {
        cell.learnedLabel.text = "Learned: 100%"
           
        } else {
            cell.learnedLabel.text = "Learned: 0%"
            cell.learnedLabel.backgroundColor = .lightGray
        }
        
        return cell
    }
}
