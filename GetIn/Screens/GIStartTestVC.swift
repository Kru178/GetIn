//
//  GIStartTestVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 25.11.2020.
//

import UIKit
import CoreData

class GIStartTestVC: UIViewController {
    
    var wordsForLearn : [WordModel]?
    var container : NSPersistentContainer?
    var wordsInTest = 10
    
    private let testView = UIView()
    private let questionView1 = UIView()
    private let questionView = UIView()
    private let questionLabel = UILabel()
    private let wordLabel = UILabel()
    private let counterLabel = UILabel()
    private var correctAnswerCounter = 0
    private var wrongAnswerCounter = 0
    
    private let button1 = UIButton()
    private let button2 = UIButton()
    private let button3 = UIButton()
    private let button4 = UIButton()
    
    private var questionArray = [WordModel]() {
        didSet {
            counterLabel.text = "\(currentQuestion) of \(answersArray.count)"
            currentQuestion += 1
        }
    }
    private var answersArray = [WordModel]()
    
    private var currentWord = WordModel(context: context)
    private var correctAnswer = ""
    private var currentQuestion = 0
    
    //MARK: - methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.isHidden = true
        
        if UserDefaults.standard.integer(forKey: "wordsQty") != 0 {
            wordsInTest = UserDefaults.standard.integer(forKey: "wordsQty")
        } else {
            wordsInTest = 10
        }
        
        guard let dict = wordsForLearn else { return }
        
        selectWords(words: dict)
        
        answersArray = questionArray
        
        configureView()
        
        startConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    private func selectWords(words: [WordModel]) {
        
        let sortedByExp = words.sorted(by: { (current, next) -> Bool in
            if current.exp < next.exp {
                return true
            } else {
                return false
            }
        })
        
        questionArray = Array(sortedByExp.prefix(wordsInTest))
        
    }
    
    private func startConfig() {
        
        let randomCurrentIndex = Int.random(in: 0..<questionArray.count)
        currentWord = questionArray[randomCurrentIndex]
        questionArray.remove(at: randomCurrentIndex)
        
        guard let translation = currentWord.translation else {
            print("\(currentWord) have no translation")
            return
        }
        correctAnswer = translation
        
        guard let word = currentWord.word?.uppercased() else {
            print("\(currentWord) have no word")
            return
        }
        wordLabel.text = word
        
        var allAnswers = answersArray
        
        guard let ind = allAnswers.firstIndex(where: {$0.translation == correctAnswer}) else {
            print("ind error")
            return
        }
        allAnswers.remove(at: ind)
        
        var answers = [WordModel]()
        
        for _ in 1...3 {
            let randomIndex = Int.random(in: 0..<allAnswers.count)
            let answerOption = allAnswers[randomIndex]
            allAnswers.remove(at: randomIndex)
            answers.append(answerOption)
        }
        answers.append(currentWord)
        
        var buttons = [button1, button2, button3, button4]
        buttons.shuffle()
        
        for (index, button) in buttons.enumerated() {
            button.setTitle(answers[index].translation, for: .normal)
            button.isEnabled = true
        }
    }
    
    @objc private func buttonPressed(sender: UIButton) {
        
        if sender.titleLabel?.text == correctAnswer {
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
            correctAnswerCounter += 1
            sender.backgroundColor = .systemGreen
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sender.backgroundColor = self.hexStringToUIColor(hex: "ffed99")
                if self.questionArray.isEmpty {
                    
                    self.presentAlertController()
                } else {
                    
                    UIView.transition(with: self.questionView, duration: 0.43,
                                      options: [.curveEaseOut, .transitionFlipFromLeft],
                                      animations: {
                                      }
                    )
                    UIView.transition(with: self.button1, duration: 0.43,
                                      options: [.curveEaseOut, .transitionFlipFromBottom],
                                      animations: {
                                      }
                    )
                    UIView.transition(with: self.button2, duration: 0.43,
                                      options: [.curveEaseOut, .transitionFlipFromBottom],
                                      animations: {
                                      }
                    )
                    UIView.transition(with: self.button3, duration: 0.43,
                                      options: [.curveEaseOut, .transitionFlipFromBottom],
                                      animations: {
                                      }
                    )
                    UIView.transition(with: self.button4, duration: 0.43,
                                      options: [.curveEaseOut, .transitionFlipFromBottom],
                                      animations: {
                                      }
                    )
                    self.startConfig()
                }
            }
            
            currentWord.exp += 100
            if currentWord.exp >= 1000 {
                currentWord.isLearned = true
            } else {
                currentWord.isLearned = false
            }
            
        } else {
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
            wrongAnswerCounter += 1
            sender.backgroundColor = .systemRed
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sender.backgroundColor = self.hexStringToUIColor(hex: "ffed99")
                
                
                
                if self.questionArray.isEmpty {
                    
                    self.presentAlertController()
                } else {
                    UIView.transition(with: self.testView, duration: 0.43,
                                      options: [.curveEaseOut, .transitionFlipFromLeft],
                                      animations: {
                                      }
                    )
//                    UIView.transition(with: self.button1, duration: 0.43,
//                                      options: [.curveEaseOut, .transitionFlipFromBottom],
//                                      animations: {
//                                      }
//                    )
//                    UIView.transition(with: self.button2, duration: 0.43,
//                                      options: [.curveEaseOut, .transitionFlipFromBottom],
//                                      animations: {
//                                      }
//                    )
//                    UIView.transition(with: self.button3, duration: 0.43,
//                                      options: [.curveEaseOut, .transitionFlipFromBottom],
//                                      animations: {
//                                      }
//                    )
//                    UIView.transition(with: self.button4, duration: 0.43,
//                                      options: [.curveEaseOut, .transitionFlipFromBottom],
//                                      animations: {
//                                      }
//                    )
                    
                    self.startConfig()
                }
            }
            
            currentWord.exp -= 200
        }
        DispatchQueue.main.async {
            
            guard let cont = self.container else { return }
            
            do {
                try cont.viewContext.save()
            } catch {
                print("saving container error - StartTestVC")
            }
        }
    }
    
    private func presentAlertController() {
        
        var message = "Your result:\n \(correctAnswerCounter) correct answers\n \(wrongAnswerCounter) wrong answers"
        
        let pct = correctAnswerCounter * 100 / answersArray.count
        print("pct = \(pct)")
        
        switch pct {
        case 100:
            message = message + "\n\nImmaculate! 🤩"
        case 90...99:
            message = message + "\n\nGood job! You are almost there! 😎"
        case 75...89:
            message = message + "\n\nYou can do better! 😉"
        case 50...74:
            message = message + "\n\nYou have to try harder! ✊"
        case 30...49:
            message = message + "\n\nHave you been studying at all? 🤨"
        case 0...29:
            message = message + "\n\nAm I a joke to you?! 😢"
        default:
            message = "What's going on? O_o"
        }
        
        let ac = UIAlertController(title: "Test Finished", message: message , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        present(ac, animated: true, completion: nil)
    }
    
    private func configureView() {
        view.addSubview(testView)
        view.addSubview(counterLabel)
        
        testView.backgroundColor = .clear
        testView.layer.cornerRadius = 10
        testView.addSubview(questionView)
        testView.addSubview(button1)
        testView.addSubview(button2)
        testView.addSubview(button3)
        testView.addSubview(button4)
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        questionView.backgroundColor = hexStringToUIColor(hex: "ffed99")
        questionView.layer.cornerRadius = 10
        questionView.layer.shadowRadius = 3
        questionView.layer.shadowOffset = CGSize(width: 1, height: 1)
        questionView.layer.shadowOpacity = 0.5
        questionView.layer.borderColor = UIColor.black.cgColor
        questionView.addSubview(questionLabel)
        questionView.addSubview(wordLabel)
        questionView.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.text = "How would you translate:"
        questionLabel.textColor = .black
        questionLabel.numberOfLines = 0
        questionLabel.font = .systemFont(ofSize: 21)
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wordLabel.textColor = .black
        wordLabel.numberOfLines = 0
        wordLabel.font = .boldSystemFont(ofSize: 23)
        wordLabel.textAlignment = .center
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        counterLabel.text = "-/-"
        counterLabel.textColor = .black
        counterLabel.numberOfLines = 0
        counterLabel.font = .systemFont(ofSize: 21)
        counterLabel.textAlignment = .center
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        button1.titleLabel?.font = .systemFont(ofSize: 20)
        button1.setTitleColor(.black, for: .normal)
        button1.layer.cornerRadius = 5
        button1.backgroundColor = hexStringToUIColor(hex: "ffed99")
        button1.layer.shadowRadius = 3
        button1.layer.shadowOffset = CGSize(width: 1, height: 1)
        button1.layer.shadowOpacity = 0.5
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button2.titleLabel?.font = .systemFont(ofSize: 20)
        button2.setTitleColor(.black, for: .normal)
        button2.layer.cornerRadius = 5
        button2.backgroundColor = hexStringToUIColor(hex: "ffed99")
        button2.layer.shadowRadius = 3
        button2.layer.shadowOffset = CGSize(width: 1, height: 1)
        button2.layer.shadowOpacity = 0.5
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button3.titleLabel?.font = .systemFont(ofSize: 20)
        button3.setTitleColor(.black, for: .normal)
        button3.layer.cornerRadius = 5
        button3.backgroundColor = hexStringToUIColor(hex: "ffed99")
        button3.layer.shadowRadius = 3
        button3.layer.shadowOffset = CGSize(width: 1, height: 1)
        button3.layer.shadowOpacity = 0.5
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button4.titleLabel?.font = .systemFont(ofSize: 20)
        button4.setTitleColor(.black, for: .normal)
        button4.layer.cornerRadius = 5
        button4.backgroundColor = hexStringToUIColor(hex: "ffed99")
        button4.layer.shadowRadius = 3
        button4.layer.shadowOffset = CGSize(width: 1, height: 1)
        button4.layer.shadowOpacity = 0.5
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testView.heightAnchor.constraint(equalToConstant: 500),
            testView.widthAnchor.constraint(equalToConstant: 350),
            
            questionView.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            questionView.topAnchor.constraint(equalTo: testView.topAnchor, constant: 50),
            questionView.widthAnchor.constraint(equalToConstant: 300),
            questionView.heightAnchor.constraint(equalToConstant: 200),
            
            questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 10),
            questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -10),
            questionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            wordLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            wordLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 40),
            wordLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -40),
            wordLabel.bottomAnchor.constraint(equalTo: questionView.bottomAnchor, constant: -40),
            
            button1.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 60),
            button1.leadingAnchor.constraint(equalTo: questionView.leadingAnchor),
            button1.widthAnchor.constraint(equalToConstant: 140),
            button1.heightAnchor.constraint(equalToConstant: 50),
            
            button2.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 60),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 20),
            button2.widthAnchor.constraint(equalToConstant: 140),
            button2.heightAnchor.constraint(equalToConstant: 50),
            
            button3.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 25),
            button3.leadingAnchor.constraint(equalTo: questionView.leadingAnchor),
            button3.widthAnchor.constraint(equalToConstant: 140),
            button3.heightAnchor.constraint(equalToConstant: 50),
            
            button4.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 25),
            button4.leadingAnchor.constraint(equalTo: button3.trailingAnchor, constant: 20),
            button4.widthAnchor.constraint(equalToConstant: 140),
            button4.heightAnchor.constraint(equalToConstant: 50),
            
            counterLabel.heightAnchor.constraint(equalToConstant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
