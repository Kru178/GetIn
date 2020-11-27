//
//  List.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import Foundation

struct List: Codable {
    
    let title: String
    var words: [Word]?
    var selected: Bool
    
}
