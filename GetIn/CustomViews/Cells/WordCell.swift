//
//  WordCell.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 06.12.2020.
//

import UIKit

class WordCell: UITableViewCell {
    
    static let reuseID = "WordCell"
    let containerView = UIView()
    let cellView = UIView()
    let wordLabel = UILabel()
    let separatorLabel = UILabel()
    let translationLabel = UILabel()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .systemGreen
        
        return progressView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        backgroundColor = .secondarySystemBackground
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowOpacity = 0.5
        containerView.addSubview(cellView)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.layer.masksToBounds = true
        cellView.addSubview(wordLabel)
        cellView.addSubview(separatorLabel)
        cellView.addSubview(translationLabel)
        cellView.addSubview(progressView)
        cellView.layer.cornerRadius = 10
        cellView.backgroundColor = .systemBackground
        
        wordLabel.textAlignment = .center
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        separatorLabel.text = "-"
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        translationLabel.textAlignment = .center
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        progressView.clipsToBounds = true
        progressView.setProgress(0.5, animated: false)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            cellView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            separatorLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            separatorLabel.topAnchor.constraint(equalTo: cellView.topAnchor),
            separatorLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            separatorLabel.widthAnchor.constraint(equalToConstant: 10),
            
            wordLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            wordLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            wordLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            wordLabel.trailingAnchor.constraint(equalTo: separatorLabel.leadingAnchor, constant: -20),
            
            translationLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            translationLabel.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 20),
            translationLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
            translationLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            
            progressView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0),
            progressView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0),
            progressView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
}
