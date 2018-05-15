//
//  Note.swift
//  Story List
//
//  Created by raluca on 15/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import Foundation

class Note {
    var id : Oid
    var title : String
    var completed : Bool
    var created_at : String
    var order : Int
    var updated_at : String
    var url : String
    
    init(id : Oid, title : String, completed : Bool, created_at : String, order : Int, updated_at : String, url : String) {
        
        self.id = id
        self.title = title
        self.completed = completed
        self.created_at = created_at
        self.order = order
        self.updated_at = updated_at
        self.url = url
    }
}

class Oid {
    var Oid : String
    init(oid : String) {
        self.Oid = oid
    }
}
