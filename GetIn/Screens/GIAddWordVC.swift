//
//  GIAddWordVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit

class GIAddWordVC: UIViewController {

    var dictionaryModel = DictionaryModel()
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        title = "Add Word"
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        label.text = "\(dictionaryModel.vocabulary[0].words.count)"
        
        
    }
}
