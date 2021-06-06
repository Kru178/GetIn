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
        return switchControl
    }()
    
    let picker = UIDatePicker()
    let setButton = UIButton(frame: .zero)
    
    let stepper = UIStepper(frame: .zero)
    let wordsNumberLabel = UILabel()
    var counter = Int()
    
    var notifSwitchState = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(switchControlNotif)
        switchControlNotif.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControlNotif.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        switchControlNotif.isHidden = true
        
        counter = UserDefaults.standard.integer(forKey: "wordsQty")
        stepper.minimumValue = 10
        stepper.maximumValue = 25
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
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(picker)
        //
        picker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        picker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        picker.widthAnchor.constraint(equalToConstant: 160).isActive = true
        picker.isHidden = true
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .inline
        
        setButton.translatesAutoresizingMaskIntoConstraints = false
        setButton.setTitle("Set", for: .normal)
        setButton.backgroundColor = .gray
        setButton.setTitleColor(.black, for: .normal)
        setButton.layer.cornerRadius = 10
        contentView.addSubview(setButton)
        
        setButton.leadingAnchor.constraint(equalTo: picker.trailingAnchor, constant: 20).isActive = true
        setButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        setButton.centerYAnchor.constraint(equalTo: picker.centerYAnchor).isActive = true
        setButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        setButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func stepperValueChanged(sender: UIStepper) {
        
        counter = Int(sender.value)
        wordsNumberLabel.text = String(counter)
    }
}
