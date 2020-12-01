//
//  GISettingsVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit

//TODO: Add functionality to change default quantity of words property (dictionaryModel.wordsInTest)

class GISettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    let tableView = UITableView()
    let sections = ["General", "Notifications", "Contacts"]
    let items = [["Number of words in test", "1B", "1C"], ["Notifications", "Sounds"], ["Contact Us", "3B", "3C"]]
    let notificationSwitch = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
    
    let soundSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        title = "Settings"
        notificationSwitch.isOn = false
        
        configureTebleView()
    }
    
    func configureTebleView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "FooterView")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ""
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        view.backgroundColor = .systemGroupedBackground
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black

//        label.text = sections[section]
        view.addSubview(label)
        return view
      }
//
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        
        
        if let cellText = cell.textLabel?.text {
            switch cellText {
            case items[0][0]:
                cell.detailTextLabel?.text = "25"
            case items[1][0]:
                cell.detailTextLabel?.text = "On"
            case items[1][1]:
                cell.detailTextLabel?.text = "On"
            default:
                cell.detailTextLabel?.text = ""
            }
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
//        view.backgroundColor = .systemGroupedBackground
//        if section == 2 {
//            return view
//        } else {
//            return nil
//        }
//        }

}
    
