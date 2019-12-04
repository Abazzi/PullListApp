//
//  ComicDetailViewController.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-11-01.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import UIKit

class ComicDetailViewController: UIViewController {
  
    //MARK: Properties
    var comic: Comic?
    
    //MARK: IBoutlets
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var creators: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var diamondID: UILabel!
    @IBOutlet weak var comicDescription: UITextView!
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        comicDescription.allowsEditingTextAttributes = false

        if let comic = comic{
            comicTitle.text = comic.title
            creators.text = comic.creators
            publisher.text = comic.publisher
            price.text = comic.price
            releaseDate.text = comic.releaseDate
            diamondID.text = comic.diamondID
            comicDescription.text = comic.description
            
            let imageURL = URL(string: "https://dak9jkjr5v1f7.cloudfront.net/images/\(comic.diamondID).thumbnail.png")!
            
            let getImageTask = URLSession.shared.downloadTask(with: imageURL, completionHandler: {
                url, responce, error in
                if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.cover?.image = image
                    }
                }
            })
            
            getImageTask.resume()

        }
    }
        
       
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


