//
//  LoginViewController.swift
//  StuKC in the Movie
//
//  Created by prk on 29/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appdDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appdDelegate.persistentContainer.viewContext
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    @IBAction func onLoginButtonClicked(_ sender: Any) {
        let username = usernameTF.text!
        let password = passwordTF.text!

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")

        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

        do {
            let result = try context.fetch(request) as! [NSManagedObject]

            if result.count == 0 {
                print("Login Failed")
            } else {

                print("Login Successful")
                if let nextView = storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") {
                    navigationController?.pushViewController(nextView, animated: true)
                }
            }
        } catch {

        }
    }
}
