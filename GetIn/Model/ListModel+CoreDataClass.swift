//
//  ListModel+CoreDataClass.swift
//  GetIn
//
//  Created by Баир Надцалов on 14.12.2020.
//
//

import Foundation
import CoreData

@objc(ListModel)
public class ListModel: NSManagedObject {

    var learned = 0
    var selected = false
}
