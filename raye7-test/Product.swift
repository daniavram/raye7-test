//
//  Product.swift
//  raye7-test
//
//  Created by Daniel Avram on 31/08/16.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    private var _id: Int!
    private var _description: String!
    private var _imageHeight: Int!
    private var _imageWidth: Int!
    private var _imageUrl: String!
    private var _price: Int!
    
    init(id: Int, desc: String, imgH: Int, imgW: Int, imgUrl: String, price: Int) {
        self._id = id
        self._description = desc
        self._imageHeight = imgH
        self._imageWidth = imgW
        self._imageUrl = imgUrl
        self._price = price
    }
    
    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: _description).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
    var id: Int {
        get {
            return _id
        }
    }
    
    var description: String {
        get {
            return _description
        }
    }
    
    var imageHeight: Int {
        get {
            return _imageHeight
        }
    }
    
    var imageWidth: Int {
        get {
            return _imageWidth
        }
    }
    
    var imageUrl: String {
        get {
            return _imageUrl
        }
    }
    
    var price: Int {
        get {
            return _price
        }
    }
}