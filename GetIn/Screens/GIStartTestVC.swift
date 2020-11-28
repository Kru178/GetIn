//
//  GIStartTestVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 25.11.2020.
//

import UIKit

class GIStartTestVC: UIViewController {

    var dictionaryModel = DictionaryModel()
    
    let testView = UIView()
    let labelView = UIView()
    let questionLabel = UILabel()
    let wordLabel = UILabel()
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    
    var questionArray = [WordModel]()
    var answerArray = ["A", "B", "C", "D"]
    let correctAnswer = "B"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.isHidden = true
        
        let dictionary = dictionaryModel.vocabulary
        var learningList = [WordModel]()
        
        for list in dictionary {
            learningList.append(contentsOf: list.words)
        }
        
        //add sort method by exp property
        
        questionArray = learningList
        
        configureView()
        buttonTitleSet()
    }
    

    func configureView() {
        view.addSubview(testView)
        
        testView.backgroundColor = .systemGray3
        testView.layer.cornerRadius = 10
        testView.addSubview(labelView)
        testView.addSubview(button1)
        testView.addSubview(button2)
        testView.addSubview(button3)
        testView.addSubview(button4)
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.backgroundColor = .systemYellow
        labelView.layer.cornerRadius = 10
//        labelView.layer.masksToBounds = true
        labelView.layer.borderWidth = 2
        labelView.layer.borderColor = UIColor.black.cgColor
        labelView.addSubview(questionLabel)
        labelView.addSubview(wordLabel)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.text = "How would you translate:"
        questionLabel.textColor = .black
//        questionLabel.backgroundColor = .green
        questionLabel.numberOfLines = 0
        questionLabel.font = .boldSystemFont(ofSize: 23)
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wordLabel.text = "\(questionArray.randomElement()?.word.uppercased() ?? "nil")"
        wordLabel.textColor = .black
//        wordLabel.backgroundColor = .green
        wordLabel.numberOfLines = 0
        wordLabel.font = .boldSystemFont(ofSize: 23)
        wordLabel.textAlignment = .center
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        button1.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button1.backgroundColor = .systemYellow
        button1.setTitleColor(.black, for: .normal)
        button1.layer.cornerRadius = 5
        button1.layer.borderWidth = 2
        button1.layer.borderColor = UIColor.black.cgColor
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button2.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button2.backgroundColor = .systemYellow
        button2.setTitleColor(.black, for: .normal)
        button2.layer.cornerRadius = 5
        button2.layer.borderWidth = 2
        button2.layer.borderColor = UIColor.black.cgColor
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button3.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button3.backgroundColor = .systemYellow
        button3.setTitleColor(.black, for: .normal)
        button3.layer.cornerRadius = 5
        button3.layer.borderWidth = 2
        button3.layer.borderColor = UIColor.black.cgColor
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button4.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button4.backgroundColor = .systemYellow
        button4.setTitleColor(.black, for: .normal)
        button4.layer.cornerRadius = 5
        button4.layer.borderWidth = 2
        button4.layer.borderColor = UIColor.black.cgColor
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testView.heightAnchor.constraint(equalToConstant: 500),
            testView.widthAnchor.constraint(equalToConstant: 350),
        
            labelView.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            labelView.topAnchor.constraint(equalTo: testView.topAnchor, constant: 50),
            labelView.widthAnchor.constraint(equalToConstant: 300),
            labelView.heightAnchor.constraint(equalToConstant: 200),
            
            questionLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10),
            questionLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10),
            questionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            wordLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            wordLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 40),
            wordLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -40),
            wordLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -40),
            
            button1.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 100),
            button1.leadingAnchor.constraint(equalTo: labelView.leadingAnchor),
            button1.widthAnchor.constraint(equalToConstant: 140),
            button1.heightAnchor.constraint(equalToConstant: 50),
            
            button2.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 100),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 20),
            button2.widthAnchor.constraint(equalToConstant: 140),
            button2.heightAnchor.constraint(equalToConstant: 50),
            
            button3.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 25),
            button3.leadingAnchor.constraint(equalTo: labelView.leadingAnchor),
            button3.widthAnchor.constraint(equalToConstant: 140),
            button3.heightAnchor.constraint(equalToConstant: 50),
            
            button4.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 25),
            button4.leadingAnchor.constraint(equalTo: button3.trailingAnchor, constant: 20),
            button4.widthAnchor.constraint(equalToConstant: 140),
            button4.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    func buttonTitleSet() {
        let buttons = [button1, button2, button3, button4]
        
        for button in buttons {
            let a = answerArray.randomElement()
            button.setTitle(a, for: .normal)
            answerArray.remove(at: answerArray.firstIndex(of: a!)!)
        }
    }
    
    
    @objc func buttonPressed(sender: UIButton) {
        if sender.titleLabel?.text == correctAnswer {
        sender.backgroundColor = .systemGreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { sender.backgroundColor = .systemYellow }
        } else {
        sender.backgroundColor = .systemRed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { sender.backgroundColor = .systemYellow }
        }
    }
}
