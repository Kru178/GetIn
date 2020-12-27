//
//  GITestVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 24.11.2020.
//

import UIKit

class GITestVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dictionaryModel = DictionaryModel()
    
    let tableView = UITableView()
    let options = ["Test Over All Lists", "Pick A List"]
    let allButton = GIButton(backgroundColor: .systemGreen, title: "Test Over All Lists")
    let pickButton = GIButton(backgroundColor: .systemGreen, title: "Pick A List")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Finish Test", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .systemGreen
        //        configureTableview()
        configureButtons()
    }
    
//
//    override func viewWillAppear(_ animated: Bool) {
//    }
    
    func configureButtons() {
        view.addSubview(allButton)
        view.addSubview(pickButton)
        
        allButton.addTarget(self, action: #selector(startTest), for: .touchUpInside)
        pickButton.addTarget(self, action: #selector(pickList), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            allButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            allButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allButton.widthAnchor.constraint(equalToConstant: 250),
            allButton.heightAnchor.constraint(equalToConstant: 80),
            
            pickButton.topAnchor.constraint(equalTo: allButton.bottomAnchor, constant: 50),
            pickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickButton.widthAnchor.constraint(equalToConstant: 250),
            pickButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    @objc func startTest() {
        var count = 0
        for i in 0...dictionaryModel.vocabulary.count - 1 {
            count += dictionaryModel.vocabulary[i].words.count
        }
        
        if count > 9 {
            let vc = GIStartTestVC()
            vc.dictionaryModel = dictionaryModel
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let ac = UIAlertController(title: "Add some words first", message: "You need to add at least 10 words to your lists to start test", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    
    @objc func pickList() {
        let choiceVC = GIListPickerVC()
        navigationController?.pushViewController(choiceVC, animated: true)
        choiceVC.dictionaryModel = dictionaryModel
    }
    
    
    func configureTableview() {
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if options[indexPath.row] == options[0] {
            
            let vc = GIStartTestVC()
            vc.dictionaryModel = dictionaryModel
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let choiceVC = GIListPickerVC()
            navigationController?.pushViewController(choiceVC, animated: true)
            choiceVC.dictionaryModel = dictionaryModel
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
