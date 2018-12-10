//
//  Tutors.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/9/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase
import Cosmos

class Tutors: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var tutorsTableView: UITableView!
    @IBOutlet weak var searchB: UISearchBar!
    
    var tutors = [User]()
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorsTableView.delegate = self
        tutorsTableView.dataSource = self
        users()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tt") as! TutorsTableViewCell
        cell.tutorsName.text = tutors[indexPath.row].name
        cell.rating.rating = tutors[indexPath.row].rating!
        
        if tutors[indexPath.row].rating! < 1.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
        }
        else if tutors[indexPath.row].rating! < 2.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
        }
        else if tutors[indexPath.row].rating! < 3.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
        }
        else if tutors[indexPath.row].rating! < 4.0{
            cell.rating.settings.emptyBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
            cell.rating.settings.filledColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
            cell.rating.settings.filledBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
        }
        
        var cl = ""
        for i in tutors[indexPath.row].offerClasses{
            cl = cl + " \(i),"
        }
        cell.classesOffering.text = cl[0..<(cl.count - 1)]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ttp") as! TutorProfile
        vc.tutor = tutors[indexPath.row]
        self.show(vc, sender: self)
    }
    
    func users(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.observe(.value) { (snapshot) in
            self.tutors = [User]()
            for i in snapshot.children{
                let newUser = User(snapshot: i as! DataSnapshot)
                self.tutors.append(newUser)
            }
            self.tutorsTableView.reloadData()
        }
    }

    
}
