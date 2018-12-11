//
//  Offers.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/6/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class Offers: NSObject {

    var firebaseKey: String?
    var offerImage: String?
    var tutorName: String?
    var comment: String?
    var title: String?
    var tutorUID: String?
    var classes = [String]()
    var ref: DatabaseReference!
    
    init(snapshot: DataSnapshot){
        self.ref = snapshot.ref
        self.firebaseKey = snapshot.key
        let value = snapshot.value as! [String: Any]
        self.offerImage = value["OfferImage"] as? String
        self.tutorName = value["TutorName"] as? String
        self.comment = value["Comment"] as? String
        self.title = value["Title"] as? String
        let cl = snapshot.childSnapshot(forPath: "Classes")
        for i in cl.children{
            let c = i as! DataSnapshot
            self.classes.append((c.value as? String)!)
        }
        self.tutorUID = value["TutorID"] as? String
    }
    
    init(tutorName: String, title: String, comment: String,tutorUID: String, offerImage: String, classes: [String]){
        self.tutorName = tutorName
        self.title = title
        self.comment = comment
        self.tutorUID = tutorUID
        self.offerImage = offerImage
        self.classes = classes
    }
    
    func toDictionary() -> [String: Any]{
        return ["TutorName": self.tutorName, "Title": self.title, "Comment": self.comment, "TutorID": self.tutorUID, "OfferImage": self.offerImage, "Classes": self.classes]
    }
    
}
