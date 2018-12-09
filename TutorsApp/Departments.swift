//
//  Departments.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/5/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class Departments: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    
    
    @IBOutlet weak var deptsTableView: UITableView!
    @IBOutlet weak var searchB: UISearchBar!
    
    var ref: DatabaseReference!
    var depts = [FirebaseDepartments]()

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDept()
        deptsTableView.delegate = self
        deptsTableView.dataSource = self
        searchB.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dept") as! DeptTableViewCell
        cell.deptName.text = depts[indexPath.row].departmentName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "off") as! OffersResult
        vc.isTutor = false
        vc.deptName = depts[indexPath.row].departmentName!
        self.show(vc, sender: self)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        dismissKeyboard()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    
    func retrieveDept(){
        self.ref = Database.database(url: "https://hubcolegial-semesterunivclasses.firebaseio.com/").reference(withPath: "UPRM")
        self.ref.child("DepartmentsList").observe(.value, with: ({ (snapshot) in
            //Retrieve data
            self.depts = [FirebaseDepartments]()
            for ds in snapshot.children{
                let newDept = FirebaseDepartments(snapshot: ds as! DataSnapshot)
                self.depts.append(newDept)
            }
            self.deptsTableView.reloadData()
        }))
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
}
