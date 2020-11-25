//
//  GIStartTestVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 25.11.2020.
//

import UIKit

class GIStartTestVC: UIViewController {

    let labelView = UIView()
    let label = UILabel()
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.isHidden = true
        
        configureView()
    }
    

    func configureView() {
        view.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.addSubview(label)
        labelView.backgroundColor = .secondarySystemBackground
        
        label.text = "Question"
        label.backgroundColor = .systemYellow
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.addSubview(button1)
        button1.setTitle("Answer", for: .normal)
        button1.backgroundColor = .systemYellow
        button1.tintColor = .black
        button1.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.addSubview(button2)
        button2.setTitle("Answer", for: .normal)
        button2.backgroundColor = .systemYellow
        button2.tintColor = .black
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.addSubview(button3)
        button3.setTitle("Answer", for: .normal)
        button3.backgroundColor = .systemYellow
        button3.tintColor = .black
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.addSubview(button4)
        button4.setTitle("Answer", for: .normal)
        button4.backgroundColor = .systemYellow
        button4.tintColor = .black
        button4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelView.heightAnchor.constraint(equalToConstant: 500),
            labelView.widthAnchor.constraint(equalToConstant: 350),
        
            label.centerXAnchor.constraint(equalTo: labelView.centerXAnchor),
            label.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 50),
            label.widthAnchor.constraint(equalToConstant: 300),
            label.heightAnchor.constraint(equalToConstant: 200),
            
            button1.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100),
            button1.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            button1.widthAnchor.constraint(equalToConstant: 140),
            button1.heightAnchor.constraint(equalToConstant: 50),
            
            button2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 20),
            button2.widthAnchor.constraint(equalToConstant: 140),
            button2.heightAnchor.constraint(equalToConstant: 50),
            
            button3.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 25),
            button3.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            button3.widthAnchor.constraint(equalToConstant: 140),
            button3.heightAnchor.constraint(equalToConstant: 50),
            
            button4.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 25),
            button4.leadingAnchor.constraint(equalTo: button3.trailingAnchor, constant: 20),
            button4.widthAnchor.constraint(equalToConstant: 140),
            button4.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
