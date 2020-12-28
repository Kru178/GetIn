//
//  GISettingsVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit
import UserNotifications


//TODO: Add functionality to change default quantity of words property (dictionary.wordsInTest)


class GISettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
//    let defaults = UserDefaults.standard
    
    let wordsQtyCell = GISettingsCell(style: .subtitle, reuseIdentifier: "words")
    let notifCell = GISettingsCell(style: .subtitle, reuseIdentifier: "notif")
    let soundsCell = GISettingsCell(style: .subtitle, reuseIdentifier: "sounds")
    let emailCell = GISettingsCell(style: .subtitle, reuseIdentifier: "email")
    
    var wordsQty = Int()
    var notifOn = Bool()
    var soundsOn = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        configureTebleView()
        configureCells()
        print(UserDefaults.standard.integer(forKey: "wordsQty"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("disappearing")
        wordsQty = wordsQtyCell.counter
        notifOn = notifCell.notifSwitchState
        soundsOn = soundsCell.soundsSwitchState
        UserDefaults.standard.set(wordsQty, forKey: "wordsQty")
        UserDefaults.standard.set(notifOn, forKey: "notifOn")
        UserDefaults.standard.set(soundsOn, forKey: "soundsOn")
    }
    
    func configureCells() {
        
        wordsQtyCell.wordsNumberLabel.isHidden = false
        wordsQtyCell.stepper.isHidden = false
        wordsQtyCell.textLabel?.text = General.NumberOfWords.description
        wordsQtyCell.detailTextLabel?.text = "10 to 25"
        wordsQtyCell.stepper.value = Double(UserDefaults.standard.integer(forKey: "wordsQty"))
        wordsQty = Int(wordsQtyCell.stepper.value)
        wordsQtyCell.wordsNumberLabel.text = "\(wordsQty)"
        
        notifCell.switchControlNotif.isHidden = false
        notifCell.switchControlNotif.isOn = UserDefaults.standard.bool(forKey: "notifOn")
        notifOn = notifCell.switchControlNotif.isOn
        notifCell.textLabel?.text = Notifications.Notifications.description
        
        soundsCell.switchControlSounds.isHidden = false
        soundsCell.switchControlSounds.isOn = UserDefaults.standard.bool(forKey: "soundsOn")
        soundsOn = soundsCell.switchControlSounds.isOn
        soundsCell.textLabel?.text = Notifications.Sounds.description

        emailCell.textLabel?.text = Feedback.Email.description
        emailCell.selectionStyle = .default
    }
    
    
    func configureTebleView() {
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GISettingsCell.self, forCellReuseIdentifier: "cell")
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height))
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
        
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .General:
            return wordsQtyCell
        case .Notifications:
            switch indexPath.row {
            case 0:
                return notifCell
            default:
                return soundsCell
            }
        case .Feedback:
            return emailCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

