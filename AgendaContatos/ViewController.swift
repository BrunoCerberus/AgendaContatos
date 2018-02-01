//
//  ViewController.swift
//  AgendaContatos
//
//  Created by Bruno Lopes de Mello on 31/01/18.
//  Copyright © 2018 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    
    //user contacts database
    let store = CNContactStore()
    
    let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: "")
    
    //predicates
    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
    
    var contacts: [Contact] = []
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.contacts.removeAll()
        self.store.requestAccess(for: .contacts) { (granted, error) in
            
            if error == nil {
                
                if granted {
                    print("Acess granted!")
                    
                    let key = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey]
                    let request = CNContactFetchRequest(keysToFetch: key as [CNKeyDescriptor])
                    
                    do {
                        try  self.store.enumerateContacts(with: request, usingBlock: { (contact, stopPointIfYouWhantStopEnumeration) in
                            
                            if let _phoneContacts = contact.phoneNumbers.first?.value {
                                let currentContact: Contact = Contact(contact.givenName, contact.familyName, _phoneContacts.stringValue)
                                self.contacts.append(currentContact)
                                print("\(contact.givenName) - \(_phoneContacts.stringValue) - \(contact.familyName)")
                            }
                            
                           
                        })
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    
                    print("Number of contacts: \(self.contacts.count)")
                    
                    for contact in self.contacts {
                        if contact.name == "Amor" {
                            print("Amor numero: \(contact.phoneNumber)")
                        }
                    }
                   
                } else {
                    print("Acess denied!")
                }
                
            } else {
                print("Failed to request acess: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! ListaContatos
        controller.contatos = self.contacts
    }

}

