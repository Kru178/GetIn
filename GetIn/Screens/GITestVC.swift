//
//  GITestVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 24.11.2020.
//

import UIKit

class GITestVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let options = ["Test Over All Lists", "Pick A List"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableview()
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
//            start test
        } else {
            let choiceVC = GIListPickerVC()
            navigationController?.pushViewController(choiceVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
