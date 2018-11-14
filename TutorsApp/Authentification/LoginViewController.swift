//
//  LoginViewController.swift
//  TutorsApp
//
//  Created by Adahid Galan on 11/14/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.delegate = self
        emailText.delegate = self
    }
    
    //---------------------Buttons------------------------------------//
    @IBAction func login(_ sender: Any) {
        tryLogin()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func createAccount(_ sender: Any) {
    }


    //---------------------Firebase----------------------------------//
    func tryLogin(){
//        loginActivity.startAnimating()
//        loginActivity.isHidden = false
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: {(user,error) in
                if user != nil{
                    //Sing in User
                    self.view.endEditing(true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainT")
                    vc?.modalPresentationStyle = .overCurrentContext
                    self.present(vc!, animated: true, completion: nil)
                }
                else{
//                    self.loginActivity.isHidden = true
//                    self.showSecondAlert()
                }
                
            })
        }
            
        else{
//            showAlert()
//            loginActivity.isHidden = true
        }
    }
    
    
    //--------------------------------Other-------------------------------//
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if textField == passwordText{
            tryLogin()
        }
        return true
    }
}
