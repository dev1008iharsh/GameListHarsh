//
//  InputVC.swift
//  GameListHarsh
//
//  Created by My Mac Mini on 07/02/24.
//

import UIKit

class InputVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtInput: UITextField!
    
    override func viewDidLoad() {
        Utility.shared.showAlertHandler(title: "It is Only working for number 4", message: "Please enter number 4", view: self) { action in
            print("")
        }
    }
    
    @IBAction func btnStart(_ sender: UIButton) {
        
        self.txtInput.resignFirstResponder()
        
        
        if let integerValue = Int(txtInput.text ?? "") {
            
            if integerValue >= 4 && integerValue <= 10 {
              
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "OutPutVC") as! OutPutVC
                secondViewController.numberOfGrid = integerValue
                self.navigationController?.pushViewController(secondViewController, animated: true)
                
            } else {
                Utility.shared.showAlertHandler(title: "Invalid number", message: "Please enter number between 4 to 10", view: self) { action in
                    print("")
                }
            }
        } else {
            print("Invalid string format")
        }
        
     
    }
    
   
     
    
}
