//
//  MyReviews.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/11/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase
import Cosmos

class MyReviews: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var revTableView: UITableView!
    
    let user = Auth.auth().currentUser
    var ref: DatabaseReference!
    var reviews = [Rating]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myUser()
        revTableView.delegate = self
        revTableView.dataSource = self
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rr") as! RRTableViewCell
        cell.author.text = reviews[indexPath.row].author
        cell.rating.rating = reviews[indexPath.row].rating!
        cell.comment.text = reviews[indexPath.row].comment
        cell.selectionStyle = .none
        
        if (reviews[indexPath.row].rating)! < 1.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
        }
        else if (reviews[indexPath.row].rating)!  < 2.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
        }
        else if (reviews[indexPath.row].rating)!  < 3.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
        }
        else if (reviews[indexPath.row].rating)!  < 4.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
        }
        return cell
    }
    
    func myUser(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((user?.uid)!).observe(.value) { (snapshot) in
            self.reviews = [Rating]()
            let newUser = User(snapshot: snapshot)
            self.reviews = newUser.reviews
            self.revTableView.reloadData()
        }
    }

}
