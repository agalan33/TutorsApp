//
//  TutorProfile.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/9/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class TutorProfile: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tutorImage: UIImageView!
    @IBOutlet weak var tutorName: UILabel!
    @IBOutlet weak var tutorRating: CosmosView!
    @IBOutlet weak var switchS: UISegmentedControl!
    @IBOutlet weak var infoTableview: UITableView!
    
    
    var tutor: User?
    var ref: DatabaseReference!
    var isClasses = true
    var isOffers = false
    var isReviews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorName.text = tutor?.name!
        tutorRating.rating = (tutor?.rating!)!
        infoTableview.delegate = self
        infoTableview.dataSource = self
        
        if tutor!.rating! < 1.0{
            tutorRating.settings.emptyBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
            tutorRating.settings.filledColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
            tutorRating.settings.filledBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
        }
        else if tutor!.rating! < 2.0{
            tutorRating.settings.emptyBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
            tutorRating.settings.filledColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
            tutorRating.settings.filledBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
        }
        else if tutor!.rating! < 3.0{
            tutorRating.settings.emptyBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
            tutorRating.settings.filledColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
            tutorRating.settings.filledBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
        }
        else if tutor!.rating! < 4.0{
            tutorRating.settings.emptyBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
            tutorRating.settings.filledColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
            tutorRating.settings.filledBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    @IBAction func classesOrOffers(_ sender: Any) {
        if switchS.selectedSegmentIndex == 0{
            isClasses = true
            isOffers = false
            isReviews = false
        }
        else if switchS.selectedSegmentIndex == 1{
            isClasses = false
            isOffers = true
            isReviews = false
        }
        else{
            isClasses = false
            isOffers = false
            isReviews = true
        }
        infoTableview.reloadData()
    }
    
    @IBAction func chatTutor(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "chat") as! Chat
        self.show(vc, sender: self)
    }
    
    
    @IBAction func openLink(_ sender: Any) {
        
            if let url = URL(string: "https://calendar.google.com/calendar/r?pli=1") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isClasses{
            return (tutor?.offerClasses.count)!
        }
        else if isOffers{
            return (tutor?.offers.count)!
        }
        else if isReviews{
            return (tutor?.reviews.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isClasses{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tct") as! TutorsClassesTableViewCell
            cell.className.text = tutor?.offerClasses[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        else if isOffers{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tot") as! TutorOffersTableViewCell
            cell.title.text = tutor?.offers[indexPath.row].title
            cell.comment.text = tutor?.offers[indexPath.row].comment
            cell.img.image = UIImage(named: (tutor?.offers[indexPath.row].offerImage)!)
            cell.selectionStyle = .none
            return cell
        }
        else if isReviews{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tor") as! TutorsReviewsTableViewCell
            cell.rating.rating = (tutor?.reviews[indexPath.row].rating)!
            cell.comment.text = tutor?.reviews[indexPath.row].comment
            cell.author.text = tutor?.reviews[indexPath.row].author
            cell.selectionStyle = .none
            
            if (tutor?.reviews[indexPath.row].rating)! < 1.0{
                cell.rating.settings.emptyBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
                cell.rating.settings.filledColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
                cell.rating.settings.filledBorderColor = UIColor(red:0.71, green:0.09, blue:0.15, alpha:1.0)
            }
            else if (tutor?.reviews[indexPath.row].rating)!  < 2.0{
                cell.rating.settings.emptyBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
                cell.rating.settings.filledColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
                cell.rating.settings.filledBorderColor = UIColor(red:0.78, green:0.47, blue:0.00, alpha:1.0)
            }
            else if (tutor?.reviews[indexPath.row].rating)!  < 3.0{
                cell.rating.settings.emptyBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
                cell.rating.settings.filledColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
                cell.rating.settings.filledBorderColor = UIColor(red:0.79, green:0.74, blue:0.12, alpha:1.0)
            }
            else if (tutor?.reviews[indexPath.row].rating)!  < 4.0{
                cell.rating.settings.emptyBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
                cell.rating.settings.filledColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
                cell.rating.settings.filledBorderColor = UIColor(red:0.20, green:0.54, blue:0.24, alpha:1.0)
            }
            return cell
        }
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return cell
    }
    
    func myUser(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((tutor?.firebaseKey)!).observe(.value) { (snapshot) in
            
        }
    }
    
}
