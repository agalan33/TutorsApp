//
//  AuthVerifierViewController.swift
//  TutorsApp
//
//  Created by Adahid Galan on 11/14/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class AuthVerifierViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tryLogin()
        // Do any additional setup after loading the view.
    }
    
    func tryLogin(){
        UIView.animate(withDuration: 30.0, animations: {
            _ = Auth.auth().addStateDidChangeListener { (auth, user) in
                // ...
                if (user != nil){
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainT")
                    vc?.modalPresentationStyle = .overCurrentContext
                    self.present(vc!, animated: true, completion: nil)
                }
                else{
                    //Continue to LoginPage
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                    vc.modalPresentationStyle = .overCurrentContext
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
