//
//  Schedule.swift
//  TutorsApp
//
//  Created by Adahid Galan on 11/14/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class Schedule: NSObject {

    var start: Timestamp?
    
    
    init(snapshot: QueryDocumentSnapshot){
        self.start = snapshot.data()["Start"] as? Timestamp
    }
    
}
