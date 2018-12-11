//
//  Detail.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/9/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class Detail: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var tutorB: UIButton!
    @IBOutlet weak var offerClasses: UILabel!
    
    var offer: Offers?
    var ref: DatabaseReference!
    var tutor: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        tutorB.setTitle(offer?.tutorName, for: .normal)
        img.image = UIImage(named: (offer?.offerImage)!)
        offerTitle.text = offer?.title
        comment.text = offer?.comment
        var cl = "Casses:"
        for i in (offer?.classes)!{
            cl = cl + " \(i),"
        }
        offerClasses.text = cl[0..<(cl.count - 1)]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    @IBAction func goToTutor(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ttp") as! TutorProfile
        vc.tutor = tutor
        self.show(vc, sender: self)
    }
    
    @IBAction func checkin(_ sender: Any) {
        if let url = URL(string: "https://calendar.google.com/calendar/r?pli=1") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func users(){
        self.ref = Database.database(url: "https://hubcolegial-tutorsapp.firebaseio.com/").reference(withPath: "Tutors")
        self.ref.child((offer?.tutorUID)!).observe(.value) { (snapshot) in
                let newUser = User(snapshot: snapshot)
                self.tutor = newUser
            print("ya")
            
        }
    }
}
