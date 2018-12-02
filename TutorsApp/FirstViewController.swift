//
//  FirstViewController.swift
//  TutorsApp
//
//  Created by Adahid Galan on 10/8/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
// lol

import UIKit
import Firebase

class FirstViewController: UIViewController {
    
    var tutors = [Tutors]()

    override func viewDidLoad() {
        super.viewDidLoad()
        rt()
    }

    
    func rt(){
        let db = Firestore.firestore()
        db.collection("HubColegial").document("Tutors").collection("TutorsList").getDocuments() { (querySnapshot, err) in
            self.tutors = [Tutors]()
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let newTutor = Tutors(snapshot: document)
                    print(newTutor.tutorClasses.count)
                    self.tutors.append(newTutor)
                }
            }
        }
    }

}

