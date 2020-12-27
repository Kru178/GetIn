//
//  GISettingsCell.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 17.12.2020.
//

import UIKit

class GISettingsCell: UITableViewCell {
    
    lazy var switchControlNotif: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = .systemGreen
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    lazy var switchControlSounds: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = .systemGreen
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    let stepper = UIStepper(frame: .zero)
    let wordsNumberLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if  self.textLabel!.text == Notifications.Notifications.description {
            contentView.addSubview(switchControlNotif)
            switchControlNotif.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            switchControlNotif.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        } else if  self.textLabel!.text == Notifications.Sounds.description {
            contentView.addSubview(switchControlSounds)
            switchControlNotif.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            switchControlNotif.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        }
        
        
        stepper.maximumValue = 25
        stepper.minimumValue = 10
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stepper)
        stepper.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        wordsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsNumberLabel.text = String(Int(stepper.value))
        contentView.addSubview(wordsNumberLabel)
        wordsNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        wordsNumberLabel.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func stepperValueChanged(sender: UIStepper) {
        wordsNumberLabel.text = String(Int(sender.value))
    }
    
    func setTag() {
        if self.textLabel!.text == Notifications.Notifications.description {
            switchControlNotif.tag = 1
        } else {
            switchControlNotif.tag = 2
        }
    }
    
    
    @objc func handleSwitchAction(sender: UISwitch) {
        if sender.tag == 1 && sender.isOn {
//            switchControl.tag(2)
            print("It's on!!! tag 1")
        } else if sender.tag == 1 && !sender.isOn {
            
            print("It's off!!! tag 1")
        } else if sender.tag == 2 && sender.isOn {
            //            switchControl.tag(2)
                        print("It's on!!! tag 2")
                    } else if sender.tag == 2 && !sender.isOn {
                        
                        print("It's off!!! tag 2")
                    }
    }
}
