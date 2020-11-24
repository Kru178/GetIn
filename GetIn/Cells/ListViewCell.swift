//
//  ListViewCell.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit

class ListViewCell: UICollectionViewCell {
    
    static let reuseID = "listCell"
    let listTitleLabel = UILabel()
    let wordsCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(listTitleLabel)
        addSubview(wordsCountLabel)
        
        let padding: CGFloat = 4
        
        listTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsCountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            listTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            listTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            listTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            listTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            wordsCountLabel.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: 8),
            wordsCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            wordsCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            wordsCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        
        
    }
}
