//
//  ViewController.swift
//  LocalStorage
//
//  Created by Umka on 25.04.2022.
//

import UIKit
import RealmSwift

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  print(Realm.Configuration.defaultConfiguration.fileURL)
    
    }
    
    func saveContact(contact: Contact) {
        try! realm.write {
            realm.add(contact)
        }
        //error
    }

    
    @IBAction func saveContact(_ sender: UIButton) {
        let contact = Contact()
        contact.name = nameTextField.text ?? ""
        contact.surname = surnameTextField.text ?? ""
        contact.phoneNumber = phoneTextField.text ?? ""
        self.view.endEditing(true)
        saveContact(contact: contact)
        
    }


}

