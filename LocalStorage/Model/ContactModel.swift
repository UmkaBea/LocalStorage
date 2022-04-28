//
//  ContactModel.swift
//  LocalStorage
//
//  Created by Umka on 28.04.2022.
//

import Foundation
import RealmSwift

class Contact: Object {
    @Persisted var name = ""
    @Persisted var surname = ""
    @Persisted var phoneNumber = ""
}
