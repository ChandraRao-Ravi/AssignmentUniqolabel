//
//  ViewController.swift
//  DemoApp
//
//  Created by Chandra Rao on 11/11/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet var viewDismiss: UIView!
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        txtName.inputView = viewDismiss
//        txtMobileNo.inputView = viewDismiss
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        view.endEditing(true)
        
        if check(forBlanks: txtName) {
            showAlert(withTitleAndMessage: "Alert", message: "Please Enter Name.")
        } else if check(forBlanks: txtMobileNo) {
            showAlert(withTitleAndMessage: "Alert", message: "Please Enter Mobile Number.")
        } else if (txtMobileNo.text!).characters.count > 10 || (txtMobileNo.text!).characters.count < 10{
            showAlert(withTitleAndMessage: "Alert", message: "Please Enter Valid Mobile Number.")
        } else {
            let otpPage : OTPViewController = storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            self.navigationController?.pushViewController(otpPage, animated: true)
        }
    }
    
    @IBAction func btnDemoClicked(_ sender: Any) {
            view.endEditing(true)
            txtName.resignFirstResponder()
            txtMobileNo.resignFirstResponder()
    }
    
    func check(forBlanks textfield: UITextField) -> Bool {
        let rawString: String? = textfield.text
        let whitespace = CharacterSet.whitespacesAndNewlines
        let trimmed: String? = rawString?.trimmingCharacters(in: whitespace)
        if (trimmed?.count ?? 0) == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func showAlert(withTitleAndMessage title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

