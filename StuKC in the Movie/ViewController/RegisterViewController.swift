//
//  RegisterViewController.swift
//  StuKC in the Movie
//
//  Created by prk on 29/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var paswordTF: UITextField!
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
    }
    

    @IBAction func onRegisterButtonClicked(_ sender: Any) {
        let username = usernameTF.text!
        let password = paswordTF.text!
        
        if (username.isEmpty || password.isEmpty) {
            return
        }
        
        if (username.count < 5) {
            return
        }
        
        if (password.count < 8) {
            return
        }
        
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = password.rangeOfCharacter(from: decimalCharacters)
        
        if decimalRange == nil {
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)!
        
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do {
            try context.save()
            print("Registered")
        } catch {
            print("Insert Failed")
        }
    }
}
