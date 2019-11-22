//
//  PullListResultsViewController.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-11-06.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import UIKit

class PullListResultsViewController: UIViewController {
//
//      var comics: [Comic] = []
//
//        @IBOutlet weak var tableView: UITableView!
//    
//        
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            tableView.delegate = self
//            tableView.dataSource = self
//            // Do any additional setup after loading the view.
//        }
//        
//        func createComicApiURL(searchBarText: String) -> URL {
//            
//            //delete any non friendly characters
//            
//            guard let cleanedString = searchBarText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
//                fatalError("Can not create appropriate URL")
//            }
//            
//            //only gets titles
//            let urlString = "https://api.shortboxed.com/comics/v1/query?title=\(cleanedString)"
//            
//            let url = URL(string: urlString)
//            return url!
//        }
//        
//        
//        /*
//        // MARK: - Navigation
//
//        // In a storyboard-based application, you will often want to do a little preparation before navigation
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            // Get the new view controller using segue.destination.
//            // Pass the selected object to the new view controller.
//        }
//        */
//
//    }
//
//    extension FullListViewController: UISearchBarDelegate{
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            guard let searchText = searchBar.text,
//            !searchText.isEmpty else {return}
//            
//            comics = []
//            
//            let url = createComicApiURL(searchBarText: searchText)
//            
//            print(url)
//            
//            let dataTask = URLSession.shared.dataTask(with: url){
//                data, responce, error in
//                
//                if let error = error {
//                    print("There was an error getting the data -\(error)")
//                }else{
//                    
//                    do{
//                        guard let data = data else {return}
//                        
//                        let decoder = JSONDecoder()
//                        
//                        let downloadedResults = try decoder.decode(Comics.self, from: data)
//                        
//                        self.comics = downloadedResults.comics
//                        
//                    } catch let error{
//                        print(error)
//                    }
//                    
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//            dataTask.resume()
//            
//            searchBar.text = ""
//            
//            searchBar.resignFirstResponder()
//           }
//       }
//
//    extension FullListViewController: UITableViewDelegate{
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//            
//    }
//
//    extension FullListViewController: UITableViewDataSource{
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return comics.count
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicTableViewCell", for: indexPath) as! ComicTableViewCell
//            
//            let comic = comics[indexPath.row]
//            
//            cell.title.text = comic.title
//            cell.creator.text = comic.creators
//
//            let imageURL = URL(string: "https://dak9jkjr5v1f7.cloudfront.net/images/\(comic.diamondID).thumbnail.png")!
//            
//            let getImageTask = URLSession.shared.downloadTask(with: imageURL, completionHandler: {
//                url, responce, error in
//                if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
//                    DispatchQueue.main.async {
//                        cell.cover.image = image
//                    }
//                }
//            })
//            
//            getImageTask.resume()
//            return cell
//        }
//        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            switch segue.identifier {
//            case "showComicDetails":
//                guard let indexPath = tableView.indexPathForSelectedRow else {return}
//                
//                let comic = comics[indexPath.row]
//                
//                let vc = segue.destination as! ComicDetailViewController
//                
//                vc.comic = comic
//            default:
//                return
//            }
//        }
//        
//        
        
}
