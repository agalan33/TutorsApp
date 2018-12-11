//
//  FirebaseClasses.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/5/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class FirebaseClasses: NSObject {
    var className: String?
    var offers = [String]()
    var ref: DatabaseReference!
    
    init(snapshot: DataSnapshot){
        self.ref = snapshot.ref
        self.className = snapshot.key
        for c in snapshot.children{
            let value = c as! DataSnapshot
            offers.append(value.value as! String)
        }
    }
}
