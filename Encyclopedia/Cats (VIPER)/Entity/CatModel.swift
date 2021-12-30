//
//  CatModel.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation

struct catInfoListModel: Codable {
    
    var cats: [catInfo]?
    
    enum CodingKeys:String,CodingKey {
        case cats =  ""
    }
}

struct catInfo: Codable {
    
    let id_cat: String
    let cat_Name: String
    //let image_Url: String
    let cat_origin: String
    let cat_Description: String
    let cat_lifeSpan: String
    
    enum CodingKeys: String, CodingKey {
        case id_cat = "id"
        case cat_Name = "name"
        case cat_origin = "origin"
        case cat_Description = "description"
        case cat_lifeSpan = "life_span"
        
    }
    
}
