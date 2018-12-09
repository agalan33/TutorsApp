//
//  FirstViewController.swift
//  TutorsApp
//
//  Created by Adahid Galan on 10/8/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
// lol

import UIKit
import Firebase

class FirstViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var classOrTutor: UISegmentedControl!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        constraint.constant = 18
        searchField.delegate = self
        if classOrTutor.selectedSegmentIndex == 0{
            searchField.placeholder = "Search for Class"
        }
        else{
            searchField.placeholder = "Search for Tutor"
        }
       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func SearchButton(_ sender: Any) {
        if searchField.text != ""{
            let vc = storyboard?.instantiateViewController(withIdentifier: "off") as! OffersResult
            if classOrTutor.selectedSegmentIndex == 0{
                vc.isTutor = false
                vc.deptName = searchField.text
            }
            else{
                vc.isTutor = true
            }
            self.dismissKeyboard()
            self.show(vc, sender: self)
        }
    }
    
    @IBAction func ClassOrTutorObserver(_ sender: Any) {
        if classOrTutor.selectedSegmentIndex == 0{
            searchField.placeholder = "Search for Class"
        }
        else{
            searchField.placeholder = "Search for Tutor"
        }
    }
    
    @IBAction func helpButton(_ sender: Any) {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = -20
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        dismissKeyboard()
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = 18
            self.view.layoutIfNeeded()
        }
    }
    
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    
}

