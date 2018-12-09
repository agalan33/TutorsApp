//
//  User.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/8/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class User: NSObject {
    var name: String?
    var rating: Double?
    var offerClasses = [String]()
    var offers = [Offers]()
    var ref: DatabaseReference!
    
    init(snapshot: DataSnapshot){
        self.ref = snapshot.ref
        let value = snapshot.value as! [String: Any]
        self.name = value["Name"] as? String
        self.rating = value["Rating"] as? Double
        let child = snapshot.childSnapshot(forPath: "TutoringClasses")
        for i in child.children{
            let p = i as! DataSnapshot
            self.offerClasses.append(p.value as! String)
        }
        let off = snapshot.childSnapshot(forPath: "Offers")
        for i in off.children{
            let newOffer = Offers(snapshot: i as! DataSnapshot)
            offers.append(newOffer)
        }
    }
}
