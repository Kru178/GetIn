//
//  GISettingsCell.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 17.12.2020.
//

import UIKit

class GISettingsCell: UITableViewCell {
    
    lazy var switchControl: UISwitch = {
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
        
        contentView.addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
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
    
    
    @objc func handleSwitchAction(sender: UISwitch) {
        if sender.isOn {
            print("It's on!")
        } else {
            print("It's off!")
        }
    }
}
