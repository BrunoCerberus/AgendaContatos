//
//  Contact.swift
//  AgendaContatos
//
//  Created by Bruno Lopes de Mello on 01/02/18.
//  Copyright © 2018 Bruno Lopes de Mello. All rights reserved.
//

import Foundation

class Contact {
    
    var name: String!
    var familyName: String!
    var phoneNumber: String!
    var email: String!
    var fullName: String!
    
    init(_ name:String, _ familyName: String, _ phoneNumber: String) {
        self.name = name
        self.familyName = familyName
        self.phoneNumber = phoneNumber
    }
}
