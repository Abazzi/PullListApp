//
//  WeeklyPullViewController.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-11-22.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import UIKit
import CoreData

class WeeklyPullViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    var pullList = [NSManagedObject]()
    var manageObjectContext: NSManagedObjectContext!
    var pullListTitles: Set<String> = []
    var comics: [Comic] = []
    var comicArray = [String]()
    var superDuperComicsArray = [Comic]()
    
    //MARK: IBoutlets
    @IBOutlet weak var resultsTableView: UITableView!
    
    @IBAction func refresh(_ sender: Any) {
        pullListTitles = []
        comicArray = []
        superDuperComicsArray = []
        createComicArray()
        pullListSearch()
        resultsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        createComicArray()
        pullListSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItemsFromCoreData()
        
    }
    
    //MARK: Functions
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
    
    func createComicArray() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PullListItems")

        do {
            pullList = try managedContext.fetch(fetchRequest)
            
        } catch{
            print("could not load save data: \(error.localizedDescription)")
        }
        
        for title in pullList as [NSManagedObject] {
            pullListTitles.insert(title.value(forKey: "title") as! String)
        }
        
        comicArray = Array(pullListTitles)

    }
       
    func pullListSearch(){
        comics = []
        
        for title in comicArray{
            let url = createComicApiURL(searchBarText: title)
            let dataTask = URLSession.shared.dataTask(with: url){
                data, responce, error in
                if let error = error {
                    print("There was an error getting the data -\(error)")
                }else{
                    do{
                        guard let data = data else {return}
                        let decoder = JSONDecoder()
                        let downloadedResults = try decoder.decode(Comics.self, from: data)
//                        self.comics = downloadedResults.comics
                        self.superDuperComicsArray += downloadedResults.comics
                    } catch let error{
                        print(error)
                    }
                    DispatchQueue.main.async {
                        self.resultsTableView.reloadData()
//                        self.saveNewItem(comic: self.comics[0])
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [Comic]!{
        return superDuperComicsArray
        
    }
    
    
    //MARK: Table View Stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superDuperComicsArray.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let comic = superDuperComicsArray[indexPath.row]
        cell.textLabel?.text = comic.title
        cell.detailTextLabel?.text = comic.price
        return cell
    }
    
    //Code to enable gestures
       func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
       
    
    //MARK: CRUD Functions
//    func loadSaveData()  {
//        let eventRequest: NSFetchRequest<PullListItemsResults> = PullListItemsResults.fetchRequest()
//        do{
//            pullList = try manageObjectContext.fetch(eventRequest)
//            self.resultsTableView.reloadData()
//        }catch
//        {
//            print("Could not load save data: \(error.localizedDescription)")
//        }
//    }

//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//
//    //MARK:Delete Gesture
//     let delete = UIContextualAction(style: .destructive, title: "Delete", handler: {
//         (action, view, completion) in
//        let pullListItem = self.superDuperComicsArray[indexPath.row]
//        self.superDuperComicsArray.remove(at: indexPath.row)
//        self.resultsTableView.reloadData()
//        do{
//            try self.manageObjectContext.save()
//        } catch let error as NSError {
//            print("Error while deleteing item: \(error.userInfo)")
//         }
//         completion(true)
//     })
//        let configuration = UISwipeActionsConfiguration(actions: [delete])
//        configuration.performsFirstActionWithFullSwipe = false
//        return configuration
//    }

    
    
    func loadItemsFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PullListItemsResults")
        
        do {
            pullList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch results - \(error) - \(error.localizedDescription)")
        }
    }
    
    func saveNewItem(comic: Comic){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PullListItemsResults", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(comic.title, forKey: "title")
        
        do {
            try managedContext.save()
            pullList.append(item)
            
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

