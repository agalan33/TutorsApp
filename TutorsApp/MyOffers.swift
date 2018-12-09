//
//  MyOffers.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/6/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class MyOffers: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{
    
    @IBOutlet weak var myOffersTableView: UITableView!
    @IBOutlet weak var blurrview: UIVisualEffectView!
    @IBOutlet weak var addOfferView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var commentTableView: UITextView!
    @IBOutlet weak var myClassesTableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var effect: UIVisualEffect!
    var classes = [String]()
    var offers = [Offers]()
    var teaching = [Bool]()
    let user = Auth.auth().currentUser
    var ref: DatabaseReference!
    var userInfo: User?
    
    override func viewDidLoad() {
        bottomConstraint.constant = 496
        self.tabBarController?.tabBar.isHidden = true
        self.effect = blurrview.effect
        blurrview.effect = nil
        blurrview.isHidden = true
        addOfferView.layer.cornerRadius = 5
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissAddOffer))
        swipeDown.direction = .down
        self.addOfferView.addGestureRecognizer(swipeDown)
        myClassesTableView.delegate = self
        myClassesTableView.dataSource = self
        commentTableView.delegate = self
        myOffersTableView.delegate = self
        myOffersTableView.dataSource = self
        createToolbar()
        retrieveUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func addNewOffer(_ sender: Any) {
        showAddOffer()
    }
    
    @IBAction func saveOffer(_ sender: Any) {
        if titleTextField.text == nil || titleTextField.text == " " || commentTableView.text == "Comment..."{
            print("error")
        }
        else{
            postOffer()
        }
    }
    
    @IBAction func cancelOffer(_ sender: Any) {
        dismissAddOffer()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myClassesTableView{
            return classes.count
        }
        else{
            return offers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myClassesTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "3tc") as! OfferClassesTableViewCell
            cell.className.text = classes[indexPath.row]
            cell.checkbox.isHidden =  !teaching[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        else{
            print(offers[indexPath.row].title!)
        }
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == myClassesTableView{
            teaching[indexPath.row] = !teaching[indexPath.row]
            tableView.reloadData()
        }
    }
    
    func postOffer(){
        let ref2 = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Departments")
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        let randomKey = self.ref.childByAutoId().key
        var oc = [String]()
        var counter = 0
        while counter < classes.count {
            if teaching[counter]{
                oc.append(classes[counter])
            }
            counter = counter + 1
        }
        let newOffer = Offers(tutorName: (userInfo?.name!)!, title: titleTextField.text!, comment: commentTableView.text!, tutorUID: (user?.uid)!, offerImage: "tutorDark", classes: oc)
        self.ref.child((user?.uid)!).child("Offers").child(randomKey!).setValue(newOffer.toDictionary())
        titleTextField.text = ""
        commentTableView.text = "Comment..."
        for i in oc{
            ref2.child(i[0..<4]).child(i).updateChildValues(["\(randomKey!)": "\((user?.uid)!)"])
        }
        dismissAddOffer()
    }
    
    func retrieveUser(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((user?.uid)!).observe(.value) { (snapshot) in
            self.classes = [String]()
            self.teaching = [Bool]()
            let newUser = User(snapshot: snapshot)
            self.userInfo = newUser
            self.classes = (self.userInfo?.offerClasses)!
            self.offers = (self.userInfo?.offers)!
            
            for c in self.classes{
                self.teaching.append(true)
            }
            print("ya")
            self.myClassesTableView.reloadData()
            self.myOffersTableView.reloadData()
        }
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .groupTableViewBackground
        toolBar.tintColor = .black
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment:""), style: .plain, target: self, action: #selector(MyOffers.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        commentTableView.inputAccessoryView = toolBar
    }
    
    func showAddOffer(){
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint.constant = 40
            self.blurrview.effect = self.effect
            self.blurrview.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissAddOffer(){
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint.constant = 496
            self.effect = self.blurrview.effect
            self.blurrview.effect = nil
            self.blurrview.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Comment..."{
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let str = textView.text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if str == ""{
            textView.textColor = .lightGray
            textView.text = "Comment..."
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
