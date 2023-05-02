//
//  DashboardViewController.swift
//  StuKC in the Movie
//
//  Created by prk on 29/04/23.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBAction func onLogOutButtonClicked(_ sender: Any) {
        
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "ManageMovieViewController") {
            navigationController?.pushViewController(nextView, animated: true)
        }
        
    }
    @IBAction func onManageMovieButtonClicked(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "ManageMoviesViewController") {
            navigationController?.setViewControllers([nextView], animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
