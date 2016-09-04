//
//  ApiGetService.swift
//  raye7-test
//
//  Created by Daniel Avram on 01/09/16.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ApiGetService {
    
    private let ITEMS = 10;
    private var _getRequestInProgress = false
    static let ApiGetServiceInstance = ApiGetService()
    
    var getRequestInProgress: Bool {
        get {
            return _getRequestInProgress
        }
    }
    
    func getProductsForVC(vc: ProductsCollectionViewController) {
        print("GET: from \(Instance.instance.productsArray.count)")
        self._getRequestInProgress = true
        Alamofire.request(.GET, "http://grapesnberries.getsandbox.com/products", parameters: ["count": ITEMS, "from": Instance.instance.productsArray.count])
            .responseJSON { response in
                if let JSON = response.result.value {
                    for item in JSON as! [[String: AnyObject]] {
                        //print(item)
                        let tempProduct = Product(id: item["id"] as! Int, desc: item["productDescription"] as! String, imgH: item["image"]!["height"] as! Int, imgW: item["image"]!["width"] as! Int, imgUrl: item["image"]!["url"] as! String, price: item["price"] as! Int)
                        Instance.instance.productsArray.append(tempProduct)
                    }
                }
            vc.reloadView()
            self._getRequestInProgress = false
        }
        
    }
    
    func downloadImageForProduct(product: Product, cell: ProductCollectionViewCell) {
        Alamofire.request(.GET, product.imageUrl)
            .responseImage { response in
                if let image = response.result.value {
                    self.putImageInCell(image, cell: cell)
                }
        }
    }
    
    func putImageInCell(image: UIImage, cell: ProductCollectionViewCell) {
        cell.imageView.image = image
    }

}