//
//  ProductsCollectionViewController.swift
//  raye7-test
//
//  Created by Daniel Avram on 31/08/16.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation
import Haneke


class ProductsCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "ProductCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //raye7 green
        collectionView?.backgroundColor = UIColor.init(red: 0.0, green: 195.0/255.0, blue: 169.0/255.0, alpha: 1.0)
        //ApiGetService.ApiGetServiceInstance.getProductsForVC(self)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        if let layout = collectionView?.collectionViewLayout as? ProductsCollectionViewLayout {
            layout.delegate = self
        }
    }
    
    func reloadView() {
        self.collectionView!.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Instance.instance.productsArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ProductCollectionViewCell
        let productId = indexPath.item
        
        cell.contentView.layer.masksToBounds = true
        cell.descriptionLbl.text = Instance.instance.productsArray[productId].description
        cell.priceLbl.text = "$\(Instance.instance.productsArray[productId].price)"
        
        cell.imageView.hnk_setImageFromURL(NSURL(string: Instance.instance.productsArray[productId].imageUrl)!)
        
        
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (Float(offsetY) >= roundf(Float(contentHeight) - Float(scrollView.frame.size.height)) && !ApiGetService.ApiGetServiceInstance.getRequestInProgress) {
            ApiGetService.ApiGetServiceInstance.getProductsForVC(self);
        }
        
//        if (offsetY > contentHeight - scrollView.frame.size.height && Instance.instance.productsArray.count > 0 && !ApiGetService.ApiGetServiceInstance.getRequestInProgress) {
//            ApiGetService.ApiGetServiceInstance.getProductsForVC(self);
//            self.reloadView()
//        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension ProductsCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let h = Instance.instance.productsArray[indexPath.item].imageHeight
        let w = Instance.instance.productsArray[indexPath.item].imageWidth
        
        return CGSize(width: w + 10, height: h + 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

}

extension ProductsCollectionViewController : ProductsCollectionViewLayoutDelegate {

    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {

        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRectWithAspectRatioInsideRect(CGSize(width: Instance.instance.productsArray[indexPath.item].imageWidth, height: Instance.instance.productsArray[indexPath.item].imageHeight), boundingRect)
        return rect.size.height
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        let product = Instance.instance.productsArray[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = product.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return height
    }
    
}