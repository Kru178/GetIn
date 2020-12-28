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
    private var dictionary = [ListModel]()

    private let options = ["Test Over All Lists", "Pick A List"]
    private let allButton = GIButton(backgroundColor: .systemGreen, title: "Test Over All Lists")
    private let pickButton = GIButton(backgroundColor: .systemGreen, title: "Pick A List")
    
//MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Finish Test", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .systemGreen
        
        print(UserDefaults.standard.integer(forKey: "wordsQty"))
        
        configureButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func configureButtons() {
        view.addSubview(allButton)
        view.addSubview(pickButton)
        
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
        
        var count = 0
        
        for index in 0..<dictionary.count {
            
            if let words = dictionary[index].words {
                count += words.count
            }
        }
        
        if count > 9 {
            let vc = GIStartTestVC()
            vc.dictionary = dictionary
            vc.container = container
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let ac = UIAlertController(title: "Add some words first", message: "You need to add at least 10 words to your lists to start test", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    
    @objc func pickList() {
        let choiceVC = GIListPickerVC()
        navigationController?.pushViewController(choiceVC, animated: true)
        choiceVC.dictionary = dictionary
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
