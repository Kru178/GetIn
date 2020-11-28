//
//  Word.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//  Modified by Bair Nadtsalov on 27.11.2020

import Foundation

class WordModel: Codable {
    
    var word: String
    var translation: String
    var inContext: String?
    var dayRepeat = 0
    
    var addedDate: Date? // for subtruct experience
    
    var exp = 0 {
        didSet {
            if exp >= minExp {
                wordType = "base"
            }
        }
    }
    
    private var maxExp = 1000
    private var minExp = 500
    private var wordType = "primary"
    
    init(word: String, translation: String) {
        self.word = word
        self.translation = translation
    }
}
