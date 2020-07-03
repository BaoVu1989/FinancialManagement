//
//  SignUpViewController.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/29/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtRepeatedPassword: UITextField!
    
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
    // This action is to sign up by using Firebase
    @IBAction func btn_SignUp(_ sender: Any) {
        let error = validateFields()
        if error != nil{
            showError(error!) // There's something wrong with the fields, show error message
        }else{
            // Create cleaned versions of the data
            let fullName = txtFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            //Create the user
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                // Check for errors
                if err != nil{
                    // There was an error creating the user
                    self.showError("Error creating user")
                }else{
                    //User was created successfully, now store the Fullname on firebase
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["fullname":fullName, "uid": result?.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Error saving user on database")
                        }
                    }
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
        
    }
    
    //This function is to show Error
    func showError(_ message:String){
        lblError.text = message
        lblError.alpha = 1
    }
    
    //This function is to make sure your password is at least 8 characters, contains a special character like @ and a number
    func isPasswordValid(_ password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //This function is to check all fields which are filled
    func validateFields()-> String?{
        if txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtRepeatedPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        let cleanedPassword = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword!) == false{
            return "Plsease make sure your password is at least 8 characters, contains a special character like @ and a number"
        }
        // Make sure password and repeatedpassword are the same
        if txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) != txtRepeatedPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines){
            return "Your password and repeat password is not the same"
        }
        return nil
    }
    func transitionToHome(){
        let screen = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        navigationController?.pushViewController(screen, animated: true)
    }
}
