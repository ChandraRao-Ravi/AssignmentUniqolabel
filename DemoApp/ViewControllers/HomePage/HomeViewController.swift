//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Chandra Rao on 11/11/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var collectionTiles: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell",for: indexPath) as! HomeCollectionViewCell
        
        if indexPath.row == 0 {
            cell.lblTileName.text = "Products"
        } else  if indexPath.row == 1 {
            cell.lblTileName.text = "Offers"
        } else if indexPath.row == 2 {
            cell.lblTileName.text = "Scan"
        } else if indexPath.row == 3 {
            cell.lblTileName.text = "About Us"
        } else if indexPath.row == 4 {
            cell.lblTileName.text = "Contact Us"
        }
        
        let borderWidth: CGFloat = 2.0
        cell.contentView.frame = cell.contentView.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        cell.contentView.layer.borderColor = UIColor.darkGray.cgColor
        cell.contentView.layer.borderWidth = borderWidth
        
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let productsController : ProductsViewController = storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
            self.navigationController?.pushViewController(productsController, animated: true)
        } else if indexPath.row == 2 {
            let qrCodeController : QRCodeViewController = storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
            self.navigationController?.pushViewController(qrCodeController, animated: true)
        } else {
            showAlert(withTitleAndMessage: "Alert", message: "Comming Soon!")
        }
        
    }

    func showAlert(withTitleAndMessage title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
