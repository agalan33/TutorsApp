//
//  SecondViewController.swift
//  TutorsApp
//
//  Created by Adahid Galan on 10/8/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileTableView: UITableView!
    
    let sections = ["", "Tutor"]
    let profileSettings = ["My Chats", "Tutors Rated"]
    let settings = ["My Information Displayed", "My Offers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.reloadData()
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
        
        return cell
    }
    

}

