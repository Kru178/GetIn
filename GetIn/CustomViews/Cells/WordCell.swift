//
//  WordCell.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 06.12.2020.
//

import UIKit

class WordCell: UITableViewCell {
    
    static let reuseID = "WordCell"
    let wordLabel = UILabel()
    let separatorLabel = UILabel()
    let translationLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
//        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 30
        clipsToBounds = true
        
        addSubview(wordLabel)
        addSubview(separatorLabel)
        addSubview(translationLabel)
        
        wordLabel.textAlignment = .center
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        separatorLabel.text = "|"
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        translationLabel.textAlignment = .center
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            separatorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separatorLabel.topAnchor.constraint(equalTo: self.topAnchor),
            separatorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorLabel.widthAnchor.constraint(equalToConstant: 10),
            
            wordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wordLabel.trailingAnchor.constraint(equalTo: separatorLabel.leadingAnchor, constant: -20),
            
            translationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            translationLabel.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 20),
            translationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            translationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
