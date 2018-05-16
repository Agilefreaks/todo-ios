//
//  ApiService.swift
//  Story List
//
//  Created by raluca on 16/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    let url  = "https://todo-backend-rails5-api.herokuapp.com/todos"
    
    func getToDo() -> [Note] {
        var notes : [Note] = []
        
        // TODO: sync vs async
        
        Alamofire.request(url, method: .get).responseData { response in
            switch response.result {
            case let .success(value):
                let jsonDecoder = JSONDecoder()
                notes = try! jsonDecoder.decode([Note].self, from: value)
            case let .failure(error):
                print(error)
            }
        }
        
        return notes
    }
    
    func postToDo(title : String){
        Alamofire.request(url, method: .post, parameters: ["title": title]).responseData { response in
            switch response.result {
            case let .success(value):
                // TODO - check response
                break
            case let .failure(error):
                // TODO - show alert
                print(error)
            }
        }
    }
    
    
}
