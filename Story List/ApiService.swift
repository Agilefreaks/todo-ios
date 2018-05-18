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
    
    func getToDo(completionHandler: (([Note]?, Error?) -> Void)!) -> Void {
        Alamofire.request(url, method: .get).responseData { response in
            switch response.result {
            case let .success(value):
                let jsonDecoder = JSONDecoder()
                let notes = try! jsonDecoder.decode([Note].self, from: value)
                return completionHandler(notes as [Note], nil)
            case .failure(_):
                return completionHandler(nil,response.result.error)
            }
        }
    }
    
    func postToDo(title : String,
                  completionHandler: ((Note?, Error?) -> Void)!) -> Void {
        Alamofire.request(url, method: .post, parameters: ["title": title]).responseData { response in
            switch response.result {
            case let .success(value):
                let jsonDecoder = JSONDecoder()
                let newTodo = try! jsonDecoder.decode(Note.self, from: value)
                return completionHandler(newTodo as Note, nil)
            case .failure(_):
                return completionHandler(nil, response.result.error)
            }
        }
    }
    
    func updateToDo(id: Oid ,
                    completed : Bool,
                    completionHandler: ((String?, Error?) -> Void)!) -> Void {
        
        let urlUpdate = url+"/\(id.oid)"
        Alamofire.request(urlUpdate, method: .patch, parameters: ["completed" : completed], encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(_):
                return completionHandler("success", nil)
            case .failure(_):
                return completionHandler("failure", response.result.error)
            }
        }
    }
    
    
}
