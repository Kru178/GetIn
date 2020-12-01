//
//  UIHelper.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 22.11.2020.
//

import UIKit

enum UIHelper {
    
    static func createLayout(in view: UIView) -> UICollectionViewFlowLayout {

        let viewWidth = view.bounds.width
        let padding: CGFloat = 12
        let itemWidth = viewWidth - 2 * padding
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 100)
        
        return flowLayout
    }
    
}
