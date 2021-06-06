//
//  GISettingsVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit
import CoreData

class GISettingsVC: UIViewController {
    
    let tableView = UITableView()
    var container : NSPersistentContainer?
    var dictionary : [ListModel]?
    
    private var lists = Int()
    private var words = Int()
    private var learned = Int()
    
    let wordsQtyCell = GISettingsCell(style: .subtitle, reuseIdentifier: "words")
    let notifCell = GISettingsCell(style: .subtitle, reuseIdentifier: "notif")
    let timeCell = GISettingsCell(style: .default, reuseIdentifier: "time")
    let emailCell = GISettingsCell(style: .subtitle, reuseIdentifier: "email")
    let rateCell = GISettingsCell(style: .subtitle, reuseIdentifier: "rate")
    let statsListsCell = GISettingsCell(style: .value1, reuseIdentifier: "statsLists")
    let statsWordsCell = GISettingsCell(style: .value1, reuseIdentifier: "statsWords")
    let statsLearnedCell = GISettingsCell(style: .value1, reuseIdentifier: "statsLearned")
    
    var wordsQty = Int()
    var notifOn = Bool()
    var date = Date()
    
    var set = Bool() {
        didSet {
            if set {
                timeCell.setButton.backgroundColor = .systemGreen
                timeCell.setButton.isEnabled = false
            } else {
                timeCell.setButton.backgroundColor = .gray
                timeCell.setButton.isEnabled = true
            }
        }
    }
    
    let email = "s.krupe@gmail.com"
    
    //MARK: - functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        configureCells()
        configureTableView()
        configurePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            self.loadStats()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        wordsQty = wordsQtyCell.counter
        
        UserDefaults.standard.set(wordsQty, forKey: "wordsQty")
        UserDefaults.standard.set(notifOn, forKey: "notifOn")
        UserDefaults.standard.set(set, forKey: "set")
        UserDefaults.standard.set(date, forKey: "date")
    }
    
    private func loadStats() {
        lists = 0
        words = 0
        learned = 0
        
        do {
            try dictionary = container?.viewContext.fetch(ListModel.fetchRequest())
        } catch {
            print("GISettingsVC: cannot load data")
        }
        
        guard let dict = dictionary else { return }
        
        for list in dict {
            lists += 1
            guard let words = list.words?.allObjects as? [WordModel] else { continue }
            
            for word in words {
                self.words += 1
                if word.isLearned {
                    learned += 1
                }
            }
        }
        DispatchQueue.main.async {
            self.statsListsCell.detailTextLabel?.text = "\(self.lists)"
            self.statsWordsCell.detailTextLabel?.text = "\(self.words)"
            self.statsLearnedCell.detailTextLabel?.text = "\(self.learned)"
        }
    }
    
    func configureCells() {
        
        wordsQtyCell.wordsNumberLabel.isHidden = false
        wordsQtyCell.stepper.isHidden = false
        wordsQtyCell.textLabel?.text = General.NumberOfWords.description
        wordsQtyCell.detailTextLabel?.text = "10 to 25"
        
        let value = Double(UserDefaults.standard.integer(forKey: "wordsQty"))
        wordsQtyCell.stepper.value = value
        wordsQty = Int(wordsQtyCell.stepper.value)
        wordsQtyCell.wordsNumberLabel.text = "\(wordsQty)"
        
        notifCell.switchControlNotif.isHidden = false
        notifCell.switchControlNotif.isOn = UserDefaults.standard.bool(forKey: "notifOn")
        notifOn = notifCell.switchControlNotif.isOn
        notifCell.textLabel?.text = Notifications.Notifications.description
        notifCell.switchControlNotif.addTarget(self, action: #selector(settingsSwitched), for: .valueChanged)
        
        timeCell.textLabel?.text = Notifications.Time.description
        timeCell.picker.isHidden = false
        timeCell.picker.addTarget(self, action: #selector(removeNotification), for: .valueChanged)
        timeCell.picker.setDate(date, animated: true)
        timeCell.setButton.isHidden = false
        timeCell.setButton.addTarget(self, action: #selector(scheduleNotification), for: .touchUpInside)
        
        emailCell.textLabel?.text = Feedback.Email.description
        emailCell.selectionStyle = .default
            
        rateCell.textLabel?.text = Feedback.RateApp.description
        rateCell.selectionStyle = .default
        
        statsListsCell.setButton.isHidden = true
        statsListsCell.textLabel?.text = Stats.AllLists.description
        statsListsCell.detailTextLabel?.text = "\(lists)"
        statsWordsCell.textLabel?.text = Stats.AllWords.description
        statsWordsCell.detailTextLabel?.text = "\(words)"
        statsLearnedCell.textLabel?.text = Stats.LearnedWords.description
        statsLearnedCell.detailTextLabel?.text = "\(learned)"
    }
    
    func configurePicker() {
        if let date = UserDefaults.standard.object(forKey: "date") as? Date {
            self.date = date
        } else {
            self.date = Date()
        }
        set = UserDefaults.standard.bool(forKey: "set")
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GISettingsCell.self, forCellReuseIdentifier: "cell")
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 1))
        footerView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = footerView
    }
    
    @objc func settingsSwitched(sender: UISwitch) {
        if sender == notifCell.switchControlNotif {
            switch sender.isOn {
            case true:
                notifOn = true
            case false:
                notifOn = false
                set = false
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        }
        self.tableView.reloadData()
    }
    
    @objc func removeNotification() {
        set = false
    }
    
    @objc func scheduleNotification() {
        set = true
        NotificationScheduleCenter.shared.scheduleNotification(for: self, time: timeCell.picker.date)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension GISettingsVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .General: return General.allCases.count
        case .Notifications: return Notifications.allCases.count
        case .Stats: return Stats.allCases.count
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            if notifCell.switchControlNotif.isOn {
                return 50
            } else {
                self.notifCell.setButton.isHidden = true
                return 0
            }
        }
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .General: return wordsQtyCell
        case .Notifications:
            switch indexPath.row {
            case 0: return notifCell
            default: return timeCell
            }
        case .Stats:
            switch indexPath.row {
            case 0: return statsListsCell
            case 1: return statsWordsCell
            default: return statsLearnedCell
            }
        case .Feedback:
            switch indexPath.row {
            case 0: return emailCell
            case 1: return rateCell
            default: return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3 && indexPath.row == 0 {
            
            if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


