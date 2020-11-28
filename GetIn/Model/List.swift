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
    var learned: Int {
        var totalExp = 0
        for word in words {
            totalExp += word.exp
            print(totalExp)
        }
        guard words.count > 0 else {
            return 0
        }
        let lrnPct = Int(totalExp * 100 / words.count / 1000)
        print(lrnPct)
        return lrnPct
    }
    
    init(title: String) {
        self.title = title
    }
}
