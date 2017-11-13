//
//  OTPViewController.swift
//  DemoApp
//
//  Created by Chandra Rao on 11/11/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var txtOTP: UITextField!
    @IBOutlet weak var btnVerifyOTP: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func bntVerifyOTPClicked(_ sender: Any) {
        view.endEditing(true)

        if check(forBlanks: txtOTP) {
            showAlert(withTitleAndMessage: "Alert", message: "Please Enter OTP.")
            
        } else if txtOTP.text == "0000" {
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.makeHomeAsRoot()
            
        } else {
            showAlert(withTitleAndMessage: "Alert", message: "Please Enter Correct OTP.")
            
        }
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
