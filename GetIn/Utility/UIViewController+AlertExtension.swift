//
//  UIViewController+AlertExtension.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 01.05.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(for time: Date) {
        let stringDate = time.convertToTime()
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Scheduled!",
                                       message: "We will be reminding you to repeat your new words at \(stringDate) every day!",
                                       preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            ac.addAction(action)
            self.present(ac, animated: true)
        }
    }
}
