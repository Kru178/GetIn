//
//  ListViewCell.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit

class ListViewCell: UICollectionViewCell {
    
    static let reuseID = "listCell"
    let cellView = UIView()
    var listTitleLabel = UILabel()
    var wordsCountLabel = UILabel()
    var learnedLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 15
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.black.cgColor
        //        layer.backgroundColor = UIColor.black.cgColor
        
        addSubview(listTitleLabel)
        addSubview(wordsCountLabel)
        addSubview(learnedLabel)
        
        let padding: CGFloat = 10
        
        listTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        learnedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        listTitleLabel.font = .boldSystemFont(ofSize: 25)
        listTitleLabel.numberOfLines = 0

        learnedLabel.clipsToBounds = true
        learnedLabel.layer.cornerRadius = 10
        learnedLabel.backgroundColor = .systemGreen
        learnedLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            
            listTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            listTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            listTitleLabel.widthAnchor.constraint(equalToConstant: 100),
            listTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            wordsCountLabel.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: 8),
            wordsCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            wordsCountLabel.widthAnchor.constraint(equalToConstant: 100),
            wordsCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            learnedLabel.heightAnchor.constraint(equalToConstant: 30),
            learnedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            learnedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            learnedLabel.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        
    }
}
