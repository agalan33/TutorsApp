//
//  OffersResult.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/8/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class OffersResult: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var noOffersView: UIView!
    @IBOutlet weak var noOffersLabel: UILabel!
    @IBOutlet weak var loadingOffers: UIActivityIndicatorView!
    
    
    
    var offers = [Offers]()
    var keys = [String]()
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    var userInfo: User?
    var isTutor = false
    var deptName: String?
    var tutorName: String?
    var ref2: DatabaseReference!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
        offersTableView.dataSource = self
        offersTableView.delegate = self
        noOffersLabel.isHidden = true
        loadingOffers.startAnimating()
        if isTutor{
            retrieveByTutor(tutorN: tutorName!)
        }
        else{
            retrieveByDept(dept: deptName!)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OT") as! OTableViewCell
        
        cell.title.text = offers[indexPath.row].title
        cell.comment.text = offers[indexPath.row].comment
        if offers[indexPath.row].offerImage == nil{
            cell.img.isHidden = true
        }
        else{
            cell.img.isHidden = false
            cell.img.image = UIImage(named: offers[indexPath.row].offerImage!)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let off = offers[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as! Detail
        vc.offer = off
        self.show(vc, sender: self)
    }
    
    func retrieveUser(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((user?.uid)!).observe(.value) { (snapshot) in
            let newUser = User(snapshot: snapshot)
            self.userInfo = newUser
            self.offers = (self.userInfo?.offers)!
            self.offersTableView.reloadData()
        }
    }
    
    
    
    func retrieveByTutor(tutorN: String){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.observe(.value) { (snapshot) in
            for i in snapshot.children{
                let newUser = User(snapshot: i as! DataSnapshot)
                if newUser.name?.lowercased() == tutorN.lowercased(){
                    self.userInfo = newUser
                    self.offers = (self.userInfo?.offers)!
                    break
                }
            }
            if self.offers.isEmpty{
                print("no hay nada")
                self.loadingOffers.stopAnimating()
                self.loadingOffers.isHidden = true
                self.noOffersLabel.isHidden = false
                self.noOffersView.isHidden = false
            }
            else{
                self.loadingOffers.stopAnimating()
                self.loadingOffers.isHidden = true
                self.noOffersLabel.isHidden = true
                self.noOffersView.isHidden = true
                self.offersTableView.reloadData()
            }
        }
    }
    
    func retrieveByDept(dept: String){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Departments")
        if dept.count > 4{
            self.ref.child(dept[0..<4]).child(dept).observe(.value) { (snapshot) in
                if snapshot.exists(){
                    self.offers = [Offers]()
                    self.keys = [String]()
                    for i in snapshot.children{
                        let p = i as! DataSnapshot
                        self.retrieveOffers(key: p.key, uid: p.value as! String)
                    }
                    self.offersTableView.reloadData()
                }
                else{
                    print("no hay nada")
                    self.loadingOffers.stopAnimating()
                    self.loadingOffers.isHidden = true
                    self.noOffersLabel.isHidden = false
                    self.noOffersView.isHidden = false
                }
            }
        }
        else{
            self.ref.child(dept).observe(.value) { (snapshot) in
                if snapshot.exists(){
                    self.offers = [Offers]()
                    for i in snapshot.children{
                        let p = i as! DataSnapshot
                        for j in p.children{
                            let d = j as! DataSnapshot
                            print(d.key)
                            self.retrieveOffers(key: d.key, uid: d.value as! String)
                        }
                    }
                    self.offersTableView.reloadData()
                }
                else{
                    print("no hay nada")
                    self.loadingOffers.stopAnimating()
                    self.loadingOffers.isHidden = true
                    self.noOffersLabel.isHidden = false
                    self.noOffersView.isHidden = false
                }
            }
        }
    }
    func retrieveOffers(key: String, uid: String){
        self.ref2 = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref2.child(uid).child("Offers").child(key).observeSingleEvent(of: .value) { (snapshot) in
            let newOffer = Offers(snapshot: snapshot)
            if !self.keys.contains(newOffer.firebaseKey!){
                self.offers.append(newOffer)
                self.keys.append(newOffer.firebaseKey!)
            }
            if self.offers.isEmpty{
                print("no hay nada")
                self.loadingOffers.stopAnimating()
                self.loadingOffers.isHidden = true
                self.noOffersLabel.isHidden = false
                self.noOffersView.isHidden = false
            }
            else{
                self.loadingOffers.stopAnimating()
                self.loadingOffers.isHidden = true
                self.noOffersLabel.isHidden = true
                self.noOffersView.isHidden = true
            }
            self.offersTableView.reloadData()
        }
    }
}
