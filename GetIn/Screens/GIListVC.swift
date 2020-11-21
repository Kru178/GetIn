//
//  GIListVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit

class GIListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var lists = [List]()
    
    var list1 = List(title: "list 1", words: nil)
    var list2 = List(title: "list 2", words: nil)
    
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
       
        
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    @objc func addList() {
        
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = lists[indexPath.row].title
        cell.detailTextLabel?.text = "Words: \(lists[indexPath.row].words?.count ?? 0)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = GIWordsVC()
        vc.listName = lists[indexPath.row].title
        vc.words = lists[indexPath.row].words ?? []
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
