//
//  MyClasses.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/9/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class MyClasses: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var myClassesTableView: UITableView!
    @IBOutlet weak var addClassesView: UIView!
    @IBOutlet weak var blurrView: UIVisualEffectView!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    var effect: UIVisualEffect!
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    var myClasses = [String]()
    var userInfo: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = blurrView.effect
        blurrView.effect = nil
        blurrView.isHidden = true
        constraint.constant = 250
        addClassesView.layer.cornerRadius = 5
        myClassesTableView.delegate = self
        myClassesTableView.dataSource = self
        classTextField.delegate = self
        myUser()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func addNewClass(_ sender: Any) {
        showAdd()
    }
    
    @IBAction func saveNewClass(_ sender: Any) {
        if classTextField.text != ""{
            addClass()
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissAdd()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myClasses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCV") as! MCTableViewCell
        cell.className.text = myClasses[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let deletedClass = myClasses[indexPath.row]
            self.ref.child((user?.uid)!).child("TutoringClasses").child(deletedClass).removeValue()
        }
    }
    
    
    func myUser(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((user?.uid)!).observe(.value) { (snapshot) in
            self.myClasses = [String]()
            let newUser = User(snapshot: snapshot)
            self.userInfo = newUser
            self.myClasses = (self.userInfo?.offerClasses)!
            self.myClassesTableView.reloadData()
        }
    }
    
    func addClass(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((user?.uid)!).child("TutoringClasses").updateChildValues([classTextField.text!: classTextField.text!])
        dismissKeyboard()
        dismissAdd()
    }
    
    
    func showAdd(){
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = -80
            self.blurrView.isHidden = false
            self.blurrView.effect = self.effect
            self.view.layoutIfNeeded()
        }
    }
    
    func dismissAdd(){
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = 250
            self.effect = self.blurrView.effect
            self.blurrView.effect = nil
            self.blurrView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = -200
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = -80
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
}
