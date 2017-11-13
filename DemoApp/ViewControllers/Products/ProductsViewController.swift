//
//  ProductsViewController.swift
//  DemoApp
//
//  Created by Chandra Rao on 12/11/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

import UIKit
import SDWebImage

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblProducts: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var arrProducts :NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.activityIndicator.startAnimating()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProductsList()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func getProductsList()  {
        
        APIHelperS.sharedInstance.callGetApiWithMethod(withMethod: "", successHandler: { (dictData) in
            print(dictData)
            if (dictData.object(forKey: "productsList") != nil) {
                self.arrProducts = (dictData.object(forKey: "productsList") as! NSArray).mutableCopy() as! NSMutableArray
                DispatchQueue.main.async {
                    self.tblProducts.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
            }
            
        }) { (strMessage) in
            print(strMessage)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : ProductsTableViewCell = tblProducts.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as! ProductsTableViewCell
        let dictProductData : NSDictionary = self.arrProducts.object(at: indexPath.row) as! NSDictionary
        
        tableCell.imgProducts.sd_setImage(with: URL(string: (dictProductData.object(forKey: "ProductImage") as? String)!), placeholderImage: UIImage(named: "placeholder"))
        
        tableCell.lblProductName.text = dictProductData.object(forKey: "ProductName") as? String
        tableCell.lblProductDescription.text = dictProductData.object(forKey: "ProductDesc") as? String

        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
