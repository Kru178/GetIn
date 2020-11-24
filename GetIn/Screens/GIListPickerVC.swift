//
//  GIListPickerVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 24.11.2020.
//

import UIKit

class GIListPickerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let tableView = UITableView()
    var lists: [List] = []
    
    var list1 = List(title: "list 1", words: nil, selected: false)
    var list2 = List(title: "list 2", words: nil, selected: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lists = [list1, list2]
        
        title = "Pick Lists"
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .systemGray2
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Test", style: .plain, target: self, action: #selector(start))
        configureTableView()
    }
    
    
    @objc func start() {
        
    }
    
    
    func configureTableView() {
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].title
        cell.tintColor = .black
        if lists[indexPath.row].selected == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lists[indexPath.row].selected.toggle()
        tableView.reloadData()
    }
    
}
