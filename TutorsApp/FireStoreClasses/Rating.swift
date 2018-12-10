//
//  Rating.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/9/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class Rating: NSObject {

    var author: String?
    var rating: Double?
    var comment: String?
    var firebaseKey: String?
    var ref: DatabaseReference!
    
    init(snapshot: DataSnapshot){
        self.ref = snapshot.ref
        self.firebaseKey = snapshot.key
        let value = snapshot.value as! [String: Any]
        self.author = value["Author"] as? String
        self.rating = value["Rating"] as? Double
        self.comment = value["Comment"] as? String
    }
}
