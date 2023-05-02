//
//  ManageMoviesViewController.swift
//  StuKC in the Movie
//
//  Created by prk on 29/04/23.
//

import UIKit
import CoreData

class ManageMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieTableViewCell
        
        cell.titleTF.text = arrOfTitle[indexPath.row]
        cell.priceTF.text = String(arrOfPrice[indexPath.row])
        
        cell.onUpdateButtonClicked = {
            self.updateData(cell: cell, indexPath: indexPath)
        }
        
        cell.onDeleteButtonClicked = {
            self.deleteData(cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    func updateData(cell: MovieTableViewCell, indexPath: IndexPath) {
        let oldTitle = arrOfTitle[indexPath.row]
        let oldPrice = arrOfPrice[indexPath.row]
        
        let newPrice = cell.priceTF.text!
        let newTitle = cell.titleTF.text!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        request.predicate = NSPredicate(format: "title == %@", oldTitle)
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                data.setValue(newTitle, forKey: "title")
                data.setValue(Int(newPrice), forKey: "price")
            }
            
            try context.save()
            loadData()
        } catch {
            print("Update Data Failed")
        }
    }
    
    func deleteData(cell: MovieTableViewCell, indexPath: IndexPath) {
        let title = arrOfTitle[indexPath.row]
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            for data in result {
                context.delete(data)
            }
            
            try context.save()
            loadData()
        } catch {
            print("Delete Failed")
        }
    }
    
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrOfTitle = [String]()
    var arrOfPrice = [Int]()
    
    @IBAction func onAddMovieButtonClicked(_ sender: Any) {
        var title = titleTF.text!.capitalized
        title = "The " + title
        
        let price = priceTF.text!
        
        let entity = NSEntityDescription.entity(forEntityName: "Movies", in: context)!
        
        let newMovie = NSManagedObject(entity: entity, insertInto: context)
        
        newMovie.setValue(title, forKey: "title")
        newMovie.setValue(Int(price), forKey: "price")
        
        do {
            try context.save()
            print("Movie Inserted")
            
            loadData()
        } catch {
            print("Insert Failed")
        }
    }
    
    func loadData() {
        arrOfTitle.removeAll()
        arrOfPrice.removeAll()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                arrOfTitle.append(data.value(forKey: "title") as! String)
                arrOfPrice.append(data.value(forKey: "price") as! Int)
            }
            
            tableView.reloadData()
        } catch {
            print("Load Data Failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    
}
