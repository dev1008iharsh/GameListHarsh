//
//  ModelGame.swift
//  GameListHarsh
//
//  Created by My Mac Mini on 07/02/24.
//

import UIKit
 
struct ModelGame: Decodable {

    let status: Int
    let appCenter: [AppCenter]
    
    enum CodingKeys: String, CodingKey {
        case status
        case appCenter = "app_center"
        
    }
    
}

struct AppCenter: Decodable {

    let id: Int
    let subCategory: [SubCategory]
    
    enum CodingKeys: String, CodingKey {
        case id
        case subCategory = "sub_category"
    }

}

struct SubCategory: Decodable {
   
    let id: Int
    let name, icon, star : String
    let installedRange: String?
    let appLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, icon, star
        case installedRange = "installed_range"
        case appLink = "app_link"
        
    }
    
}
