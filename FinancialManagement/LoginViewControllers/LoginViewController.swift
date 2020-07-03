//
//  LoginViewController.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/29/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblError.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btn_Login(_ sender: Any) {
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if email == "" || password == ""{
            showError("Please fill in all Fields")
        }else{
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if error != nil{
                    self.showError("Wrong password or email")
                }else{
                    let screen = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                    self.navigationController?.pushViewController(screen, animated: true)
                }
            }
        }
    }
    
    //This function is to show error
    func showError(_ message: String){
        lblError.text = message
        lblError.alpha = 1
    }
}
