//
//  WeeklyPullViewController.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-11-22.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import UIKit
import CoreData

class WeeklyPullViewController: UIViewController, UITableViewDataSource {
    
    
    var pullList = [NSManagedObject]()
    var manageObjectContext: NSManagedObjectContext!
    var comics: [Comic] = []

    @IBOutlet weak var resultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.loadSaveData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        
//            loadItemsFromCoreData()
    }
    
    func createComicApiURL(searchBarText: String) -> URL {
           
           //Delete any non friendly characters
           
           guard let cleanedString = searchBarText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
               fatalError("Can not create appropriate URL")
           }
           
           //only gets titles
           let urlString = "https://api.shortboxed.com/comics/v1/query?title=\(cleanedString)"
           
           let url = URL(string: urlString)
           return url!
       }
    
    func createComicArray(comic: Comic){
        
    }
    
    //MARK: Table View Stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let item = pullList[indexPath.row]
        
        cell.textLabel?.text = item.value(forKey: "title") as? String
        
        return cell
        
    }
    
    func loadSaveData()  {

        let eventRequest: NSFetchRequest<PullListComicResults> = PullListComicResults.fetchRequest()
        do{
            pullList = try manageObjectContext.fetch(eventRequest)
            self.resultsTableView.reloadData()
        }catch
        {
            print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    
    func loadItemsFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PullListItems")
        
        do {
            pullList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch results - \(error) - \(error.localizedDescription)")
        }
    }
    
    func saveNewItem(comic: Comic){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PullListComicResults", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(comic.title, forKey: "title")
        item.setValue(comic.creators, forKey: "creator")
        item.setValue(comic.description, forKey: "description")
        item.setValue(comic.diamondID, forKey: "diamondID")
        item.setValue(comic.publisher, forKey: "publisher")
        item.setValue(comic.price, forKey: "price")
        item.setValue(comic.releaseDate, forKey: "releaseDate")
        
        do {
            try managedContext.save()
            pullList.append(item)
            
            //{
        }catch let error as NSError{
            print("Failed saving: \(error) - \(error.description)")
        }
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

