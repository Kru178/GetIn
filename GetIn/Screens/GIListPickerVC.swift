//
//  GIListPickerVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 24.11.2020.
//

import UIKit

class GIListPickerVC: UIViewController {
    
    var dictionary : [ListModel]?
    private var customDict : [ListModel]?
    
    private let tableView = UITableView()
    
    //MARK: - Methods
    
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
    
    @objc private func start() {
        
        //FIXME: check words count. If count less than 10 do not start the test
        
        customDict = []
        
        guard let dict = dictionary else { return }
        
        for list in dict {
            if list.selected {
                customDict?.append(list)
            }
        }
        //FIXME: turn on the start button when at least one list is selected
        if customDict == nil {
           return
        }

        let vc = GIStartTestVC()
        vc.dictionary = customDict
        navigationController?.pushViewController(vc, animated: true)
        
        //FIXME: uncheck lists when test have started
    }
    
    
    private func configureTableView() {
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension GIListPickerVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let dict = dictionary else { return 0 }
        
        return dict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listRowAt = dictionary?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listRowAt?.title
        cell.tintColor = .black
        
        if listRowAt?.selected == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dictionary?[indexPath.row].selected.toggle()
        tableView.reloadData()
    }
}
