//
//  Instance.swift
//  raye7-test
//
//  Created by Daniel Avram on 31/08/16.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import Foundation
import UIKit

class Instance {
    
    var productsArray: [Product]!
    static let instance = Instance()
    
    init() {
        productsArray = [Product]()
    }
    
    func testPrint() {
        for iterator in productsArray {
            print(iterator.description)
        }
    }
    
}