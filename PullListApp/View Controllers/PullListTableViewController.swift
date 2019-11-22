//
//  PullListTableViewController.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-11-03.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import UIKit
import CoreData

class PullListTableViewController: UITableViewController {

  //MARK: - Properties
  //    var items = [String]()
      var items = [NSManagedObject]()
      
      
      @IBAction func addNewItem(_ sender: Any) {
          print("Add button clicked")
          
          let alert = UIAlertController(title: "Add New Item", message: "Add a Comic Series to your Pull List", preferredStyle: .alert)
          
          alert.addTextField()
          
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          
          let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
              action in
              guard let textfield = alert.textFields?.first, let itemToSave = textfield.text else {
                  return
              }
              
  //            self.items.append(itemToSave)
              self.saveNewItem(name: itemToSave)
              self.tableView.reloadData()
          })
          
          alert.addAction(cancelAction)
          alert.addAction(saveAction)
          
          present(alert, animated: true, completion: nil)
      }
      
      
      //MARK: - View Methods
      override func viewDidLoad() {
          super.viewDidLoad()

      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          loadItemsFromCoreData()
      }

      // MARK: - Table view data source

      override func numberOfSections(in tableView: UITableView) -> Int {
          // #warning Incomplete implementation, return the number of sections
          return 1
      }

      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of rows
          return items.count
      }

      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "pullListResultCell", for: indexPath)
          let item = items[indexPath.row]
          // Configure the cell...
  //        cell.textLabel?.text = item
          cell.textLabel?.text = item.value(forKey: "title") as? String
          
          return cell
      }
      

      /*
      // Override to support conditional editing of the table view.
      override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          // Return false if you do not want the specified item to be editable.
          return true
      }
      */

      /*
      // Override to support editing the table view.
      override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              // Delete the row from the data source
              tableView.deleteRows(at: [indexPath], with: .fade)
          } else if editingStyle == .insert {
              // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
          }
      }
      */

      /*
      // Override to support rearranging the table view.
      override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

      }
      */

      /*
      // Override to support conditional rearranging of the table view.
      override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
          // Return false if you do not want the item to be re-orderable.
          return true
      }
      */

      /*
      // MARK: - Navigation

      // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
      }
      */

      //MARK: - Core Data save and fetch functions
      func saveNewItem(name: String){
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let entity = NSEntityDescription.entity(forEntityName: "PullListItems", in: managedContext)!
          
          let item = NSManagedObject(entity: entity, insertInto: managedContext)
          
          item.setValue(name, forKey: "title")
          
          do {
              try managedContext.save()
              items.append(item)
              
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
              items = try managedContext.fetch(fetchRequest)
          }catch let error as NSError {
              print("Could not fetch results - \(error) - \(error.localizedDescription)")
          }
      }
  }
