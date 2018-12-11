//
//  SecondViewController.swift
//  TutorsApp
//
//  Created by Adahid Galan on 10/8/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class Profile: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myStatus: UILabel!
    
    
    let sections = ["", "Tutor"]
    let profileSettings = ["My Chats", "Tutors Rated"]
    let settings = ["My Classes", "My Offers", "My Reviews"]
    var userInfo: User?
    
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.reloadData()
        myStatus.text = "Tutor"
        myUser()
    }
    
    
    @IBAction func help(_ sender: Any) {
        if let url = URL(string: "https://github.com/agalan33/TutorsApp") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return profileSettings.count
        }
        else{
            return settings.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Cell") as! ProfileTableViewCell
        if indexPath.section == 0{
            cell.SettingName.text = profileSettings[indexPath.row]
        }
        else{
            cell.SettingName.text = settings[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "myOffers") as! MyOffers
            self.show(vc, sender: self)
        }
        else if indexPath.section == 1 && indexPath.row == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "mc") as! MyClasses
            self.show(vc, sender: self)
        }
        else if indexPath.section == 0 && indexPath.row == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "Cht") as! ChatsViewController
            self.show(vc, sender: self)
        }
        else if indexPath.section == 0 && indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TRT") as! TutorsRated
            self.show(vc, sender: self)
        }
        else if indexPath.section == 1 && indexPath.row == 2{
            let vc = storyboard?.instantiateViewController(withIdentifier: "REV") as! MyReviews
            self.show(vc, sender: self)
        }
    }
    
    func myUser(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((user?.uid)!).observe(.value) { (snapshot) in
            let newUser = User(snapshot: snapshot)
            self.userInfo = newUser
            self.myName.text = self.userInfo?.name!
            self.myStatus.text = "My Rating: \(self.userInfo?.rating! ?? 0.0)"
        }
    }
}

