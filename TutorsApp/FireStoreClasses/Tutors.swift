//
//  Tutors.swift
//  TutorsApp
//
//  Created by Adahid Galan on 11/14/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class Tutors: NSObject {
    
    var firebaseKey: String?
    var name: String?
    var rating: Double?
    var schedule = [Schedule]()
    var tutorClasses = [String]()
    
    init(snapshot: QueryDocumentSnapshot){
        self.firebaseKey = snapshot.documentID
        self.tutorClasses = snapshot.data()["TutorClasses"] as? [String] ?? ["No Classes"]
        self.name = snapshot.data()["Name"] as? String
        self.rating = snapshot.data()["Rating"] as? Double
        let schedule = snapshot.data()["Schedule"] as? [String: Any]
        for i in ((schedule?.keys)!){
            let newSchedule = Schedule.init(snapshot: (i as? QueryDocumentSnapshot)!)
        }
        
    }

}
