//
//  PullListViewController.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-11-22.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import UIKit
import CoreData

class PullListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    var pullList = [NSManagedObject]()
    var manageObjectContext: NSManagedObjectContext!
    
    
    //MARK: IBOutlets
    @IBOutlet weak var pullListTableView: UITableView!
    
    @IBAction func addToPull(_ sender: Any) {                
        //Alert that prompts the user
        let alert = UIAlertController(title: "Add New Comic", message: "Enter a new Comic Title to your Pull List", preferredStyle: .alert)
                
        alert.addTextField()
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            action in
        guard let textfield = alert.textFields?.first, let itemToSave = textfield.text
            else {
                return
            }
                    
        self.saveNewItem(title: itemToSave)
        self.pullListTableView.reloadData()
    })
        
                
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
                
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //Code to enable gestures
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   //MARK: Custom Swipe action for Deleting and Editing
   func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
       //Edit Gesture
       let edit = UIContextualAction(
           style: .normal, title: "Edit", handler: {
               (action, view, completion) in
                let pullListItem = self.pullList[indexPath.row]
            let alert = UIAlertController(title: "Enter Title Below", message: "What is the new title", preferredStyle: .alert)
               
               alert.addTextField()
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               
               let changeAction = UIAlertAction(title: "Save", style: .default, handler: {
                       action in
                   guard let textfield = alert.textFields?.first, let itemToSave = textfield.text
                       else {
                           return
                       }
                pullListItem.setValue(itemToSave, forKey: "title")
                self.pullListTableView.reloadData()
                   

               })
               alert.addAction(cancelAction)
               alert.addAction(changeAction)
                              
               self.present(alert, animated: true, completion: nil)
               
               completion(true)
       })
       
       
       //Delete Gesture
       let delete = UIContextualAction(style: .destructive, title: "Delete", handler: {
           (action, view, completion) in
           let pullListItem = self.pullList[indexPath.row]
           self.manageObjectContext.delete(pullListItem)
           do{
               try self.manageObjectContext.save()
           } catch let error as NSError {
               print("Error while deleteing item: \(error.userInfo)")
           }
           self.loadSaveData()
           completion(true)
       })
       edit.backgroundColor = .blue
       let configuration = UISwipeActionsConfiguration(actions: [edit,delete])
       configuration.performsFirstActionWithFullSwipe = false
       return configuration
   }
    
    //Custom Swipe action
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        pullListTableView.delegate = self
        pullListTableView.dataSource = self
        
        self.loadSaveData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadItemsFromCoreData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return pullList.count
        }

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
            let item = pullList[indexPath.row]
            
            cell.textLabel?.text = item.value(forKey: "title") as? String
            
            return cell
        }
    
    //MARK: - Core Data save and fetch functions
    func saveNewItem(title: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PullListItems", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(title, forKey: "title")
        
        do {
            try managedContext.save()
            pullList.append(item)
            
            //{
        }catch let error as NSError{
            print("Failed saving: \(error) - \(error.description)")
        }
    }
    
    //MARK: - Retrieve items
    func loadItemsFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PullListItems")
        
        do {
            pullList = try managedContext.fetch(fetchRequest)
        }catch let error as NSError {
            print("Could not fetch results - \(error) - \(error.localizedDescription)")
        }
    }
    
    func getContext(){
        
    }
    
    func loadSaveData()  {
        let eventRequest: NSFetchRequest<PullListItems> = PullListItems.fetchRequest()
        do{
            pullList = try manageObjectContext.fetch(eventRequest)
            self.pullListTableView.reloadData()
        }catch
        {
            print("Could not load save data: \(error.localizedDescription)")
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


