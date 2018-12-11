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
    
    var possibleInputs = ["Math" : "MATE", "Mathematics": "MATE", "Programming" : "ICOM", "Biology" : "BIOL", "Chemistry" : "QUIM", "Quimica" : "QUIM", "Matematicas" : "MATE", "Matematica" : "MATE", "Programacion" : "ICOM", "Fisica" : "FISI", "Industrial" : "ININ", "Mecanica" : "INME", "Biologia" :"BIOL"]

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
        searchField.backgroundColor = .groupTableViewBackground
    }
    
    @IBAction func SearchButton(_ sender: Any) {
        if searchField.text != ""{
            let vc = storyboard?.instantiateViewController(withIdentifier: "off") as! OffersResult
            if classOrTutor.selectedSegmentIndex == 0{
                vc.isTutor = false
                let keys = Array(possibleInputs.keys)
                for i in keys{
                    if i.lowercased() == searchField.text?.lowercased(){
                        vc.deptName = possibleInputs[i]
                    }
                }
                if !keys.contains((searchField.text?.lowercased())!){
                    vc.deptName = searchField.text
                }
            }
            else{
                vc.isTutor = true
                vc.tutorName = searchField.text
            }
            self.dismissKeyboard()
            self.show(vc, sender: self)
        }
        
        else{
            searchField.backgroundColor = UIColor(red:0.94, green:0.33, blue:0.27, alpha:1.0)
        }
    }
    
    @IBAction func ClassOrTutorObserver(_ sender: Any) {
        if classOrTutor.selectedSegmentIndex == 0{
            searchField.placeholder = "Search for Class"
            searchField.autocapitalizationType = .allCharacters
        }
        else{
            searchField.placeholder = "Search for Tutor"
            searchField.autocapitalizationType = .sentences
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

