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
    var counter = 0
    var notifSwitchState = false
    var soundsSwitchState = false
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(switchControlNotif)
        switchControlNotif.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControlNotif.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        switchControlNotif.isHidden = true
        
        contentView.addSubview(switchControlSounds)
        switchControlSounds.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControlSounds.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        switchControlSounds.isHidden = true
        
        
        stepper.maximumValue = 25
        stepper.minimumValue = 10
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stepper)
        stepper.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stepper.isHidden = true
        
        wordsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsNumberLabel.text = String(Int(stepper.value))
        contentView.addSubview(wordsNumberLabel)
        wordsNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        wordsNumberLabel.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -20).isActive = true
        wordsNumberLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func stepperValueChanged(sender: UIStepper) {
        wordsNumberLabel.text = String(Int(sender.value))
        
        counter = Int(sender.value)
        //TODO: save to user defaults
    }
    
    
    
    
    @objc func handleSwitchAction(sender: UISwitch) {
        if sender == switchControlNotif && !sender.isOn {
            notifSwitchState = false
            //            DispatchQueue.main.async {
            //                self.switchControlSounds.setOn(false, animated: true)
            //            }
        } else if sender == switchControlNotif && sender.isOn {
            notifSwitchState = true
        } else if sender == switchControlSounds && !sender.isOn {
            soundsSwitchState = false
        } else if sender == switchControlSounds && sender.isOn {
            soundsSwitchState = true
        }
    }
}
