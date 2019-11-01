//
//  Comics.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-10-31.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import Foundation

struct Comics: Codable{
    var results: [Comic]
}

struct Comic: Codable{
    
    enum CodingKeys: String, CodingKey{
        case publisher = "publisher"
        case description = "description"
        case title = "title"
        case price = "price"
        case creators = "creators"
        case releaseDate = "release_date"
        case diamondID = "diamond_id"
    }
    
    //MARK: - Properties
    var publisher: String
    var description: String
    var title: String
    var price: String
    var creators: String
    var releaseDate: String
    var diamondID: String

}
