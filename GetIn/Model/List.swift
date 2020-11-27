//
//  List.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import Foundation

class List: Codable {
    
    var title: String
    var words = [WordModel]()
    var selected = false
    
    init(title: String) {
        self.title = title
    }
}
