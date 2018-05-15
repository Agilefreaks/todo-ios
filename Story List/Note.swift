//
//  Note.swift
//  Story List
//
//  Created by raluca on 15/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import Foundation

class Note : Codable {
    var _id : Oid
    var title : String
    var completed : Bool
    var created_at : String
    var order : Int
    var updated_at : String
    var url : String
}

class Oid : Codable {
    var oid : String
    init(oid : String) {
        self.oid = oid
    }
    
    enum CodingKeys: String, CodingKey
    {
        case oid = "$oid"
    }
}



