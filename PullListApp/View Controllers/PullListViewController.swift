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
    
    var pullList = [NSManagedObject]()
    
    
    //MARK: IBOutlets
    @IBOutlet weak var pullListTableView: UITableView!
    
    @IBAction func addToPull(_ sender: Any) {
        print("Add button clicked")
                
        let alert = UIAlertController(title: "Add New Comic", message: "Enter a new Comic Title to your Pull List", preferredStyle: .alert)
                
        alert.addTextField()
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            action in
        guard let textfield = alert.textFields?.first, let itemToSave = textfield.text
            else {
                return
            }
                    
        //            self.items.append(itemToSave)
            self.saveNewItem(name: itemToSave)
            self.pullListTableView.reloadData()
    })
                
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
                
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveNewItem(name: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PullListItems", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(name, forKey: "title")
        
        do {
            try managedContext.save()
            pullList.append(item)
            
            //{
        }catch let error as NSError{
            print("Failed saving: \(error) - \(error.description)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullListTableView.delegate = self
        pullListTableView.dataSource = self
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


