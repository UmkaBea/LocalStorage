//
//  ContactsViewController.swift
//  LocalStorage
//
//  Created by Umka on 28.04.2022.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    

    @IBOutlet weak var contactsTable: UITableView!
    private var contact: [Contact]?
    private let cellIdentifier = "ContactCell"
    private var lastSelectedIndex = 0
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.contactsTable.rowHeight = 115;
             }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        contactsTable.isHidden = true
        fetchContacts()
    }
    
    private func initialSetup() {
        self.contactsTable.delegate = self
        self.contactsTable.dataSource = self
        self.registerNibs()
    }
    
    private func registerNibs() {
        contactsTable.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @IBAction private func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func fetchContacts(){
        let contact = realm.objects(Contact.self)
        if contact.count > 0 {
            var allContacts = [Contact]()
            for contact in contact {
                allContacts.append(contact)
            }
            ContactFetched(contact: allContacts)
        } else {
            ContactFetched(contact: [])
        }
    }

    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contact?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactCell = self.contactsTable.dequeueReusableCell(withIdentifier: cellIdentifier) as! ContactCell
        cell.nameTextField.text = "First Name: \(self.contact?[indexPath.row].name ?? "")"
        cell.surnameTextField.text = "Second Name: \(self.contact?[indexPath.row].surname ?? "")"
        cell.phoneTextField.text = "Phone Number: \(self.contact?[indexPath.row].phoneNumber ?? "")"
        return cell
    }
    
    func ContactFetched(contact: [Contact]) {
        if contact.count > 0 {
            self.contact = contact
            DispatchQueue.main.async {
                self.contactsTable.reloadData()
                self.contactsTable.isHidden = false
            }
        } else {
            self.contactsTable.isHidden = true
           
    }
    }
   
       
}
