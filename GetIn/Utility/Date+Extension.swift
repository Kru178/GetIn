//
//  Date+Extension.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 03.05.2021.
//

import Foundation

extension Date {
    
    func convertToStringFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }
    
    
    func convertToTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
