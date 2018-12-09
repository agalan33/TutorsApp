//
//  FirebaseDepartments.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/5/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Firebase

class FirebaseDepartments: NSObject {
    
    var departmentName: String?
    var classes = [FirebaseClasses]()
    var ref: DatabaseReference!
    
    init(snapshot: DataSnapshot){
        self.ref = snapshot.ref
        self.departmentName = snapshot.key
        for c in snapshot.children{
            let sn = c as! DataSnapshot
            let newClass = FirebaseClasses(snapshot: sn)
            self.classes.append(newClass)
        }
    }

}
