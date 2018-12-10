//
//  Chat.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/9/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit

class Chat: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var chatTableview: UITableView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var chatT: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constraint.constant = 0
        chatT.delegate = self
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = 240
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.constraint.constant = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }

}
