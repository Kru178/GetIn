//
//  GISettingsVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit
import UserNotifications

//TODO: Add functionality to change default quantity of words property (dictionaryModel.wordsInTest)

class GISettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        title = "Settings"
        configureTebleView()
    }

    
    func configureTebleView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        footerView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = footerView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .General: return General.allCases.count
        case .Notifications: return Notifications.allCases.count
        case .Feedback: return Feedback.allCases.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        view.backgroundColor = .systemGroupedBackground
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black

        label.text = Section(rawValue: section)?.description
        view.addSubview(label)
        return view
      }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .General:
            let general = General(rawValue: indexPath.row)
            cell.textLabel?.text = general?.description
        case .Notifications:
            let notification = Notifications(rawValue: indexPath.row)
            cell.textLabel?.text = notification?.description
        case .Feedback:
            let feedback = Feedback(rawValue: indexPath.row)
            cell.textLabel?.text = feedback?.description
        }
        
        
        
//        
//        if let cellText = cell.textLabel?.text {
//            switch cellText {
//            case items[0][0]:
//                cell.detailTextLabel?.text = "25"
//            case items[1][0]:
//                cell.detailTextLabel?.text = "On"
//            case items[1][1]:
//                cell.detailTextLabel?.text = "On"
//            default:
//                cell.detailTextLabel?.text = ""
//            }
//        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    
}
    
