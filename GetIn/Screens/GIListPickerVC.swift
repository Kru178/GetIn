//
//  GIListPickerVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 24.11.2020.
//

import UIKit

class GIListPickerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dictionaryModel = DictionaryModel()
    private var customDict = DictionaryModel()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pick Lists"
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Finish Test", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemGray2
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Test", style: .plain, target: self, action: #selector(start))
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false

    }
    
    
    @objc func start() {
        
        customDict.vocabulary = []
        
        for list in dictionaryModel.vocabulary {
            if list.selected {
                customDict.vocabulary.append(list)
            }
        }
        //FIXME: turn on the start button when at least one list is selected
        if customDict.vocabulary.isEmpty {
           return
        }
        
        let vc = GIStartTestVC()
        vc.dictionaryModel = customDict
        navigationController?.pushViewController(vc, animated: true)
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
        return dictionaryModel.vocabulary.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listRowAt = dictionaryModel.vocabulary[indexPath.row]
        
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listRowAt.title
        cell.tintColor = .black
        if listRowAt.selected == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dictionaryModel.vocabulary[indexPath.row].selected.toggle()
        tableView.reloadData()
    }
    
}
