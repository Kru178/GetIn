//
//  GITestVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 24.11.2020.
//

import UIKit
import CoreData

class GITestVC: UIViewController {
    
    var container : NSPersistentContainer?
    private var dictionary: [ListModel]?

    private let options = ["Test Over All Lists", "Pick A List"]
    private let allButton = GIButton(backgroundColor: .systemBackground, title: "Test Over All Lists")
    private let pickButton = GIButton(backgroundColor: .systemBackground, title: "Pick A List")
    
//MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back To Options", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .systemGreen
        
        configureButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func configureButtons() {
        view.addSubview(allButton)
        view.addSubview(pickButton)
        
        allButton.setTitleColor(.black, for: .normal)
        pickButton.setTitleColor(.black, for: .normal)
        allButton.addTarget(self, action: #selector(startTest), for: .touchUpInside)
        pickButton.addTarget(self, action: #selector(pickList), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            allButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            allButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allButton.widthAnchor.constraint(equalToConstant: 250),
            allButton.heightAnchor.constraint(equalToConstant: 80),
            
            pickButton.topAnchor.constraint(equalTo: allButton.bottomAnchor, constant: 50),
            pickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickButton.widthAnchor.constraint(equalToConstant: 250),
            pickButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    @objc func startTest() {
        
        guard let dict = dictionary else { return }
        
        let wordsToLearn = selectWords(dict: dict)
        
        if wordsToLearn.count > 9 {
            let vc = GIStartTestVC()
            vc.wordsForLearn = wordsToLearn
            vc.container = container
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let ac = UIAlertController(title: "Add some words first", message: "You need to have at least 10 words in your lists to start test", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    private func selectWords(dict: [ListModel]) -> [WordModel]{
        
        var learningList = [WordModel]()
        
        for list in dict {
            
            guard let words = list.words?.allObjects as? [WordModel] else { continue }
            
            var finalList = words
            finalList.removeAll()
            for word in words {
                if !word.isLearned {
                    finalList.append(word)
                }
            }
            
            learningList.append(contentsOf: finalList)
        }
        
        return learningList
    }
    
    @objc func pickList() {
        let choiceVC = GIListPickerVC()
        navigationController?.pushViewController(choiceVC, animated: true)
        guard let dict = dictionary else { return }
        choiceVC.dictionary = dict
    }
    
    private func fetchData() {
        
        guard let cont = container else { return }
        
        do {
            self.dictionary = try cont.viewContext.fetch(ListModel.fetchRequest())
            
        } catch {
            print("fetchData fail: GITestVC")
        }
    }
}
