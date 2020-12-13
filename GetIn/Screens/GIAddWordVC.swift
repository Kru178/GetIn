//
//  GIAddWordVC.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit
import SafariServices

class GIAddWordVC: UIViewController {

    var dictionaryModel = DictionaryModel()
    
    private let label = UILabel()
    
    let url = URL(string: "https://translate.google.ru/?hl=ru&tab=wT")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
//        title = "Add Word"
        
//        view.addSubview(label)
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        presentSafariVC(with: url!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        label.text = "\(dictionaryModel.vocabulary[0].words.count)"
        
        
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
