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
    
    func updateToDo(id: Oid , completed : Bool){
        let urlUpdate  = "https://todo-backend-rails5-api.herokuapp.com/todos/\(id.oid)"
        Alamofire.request(urlUpdate, method: .patch, parameters: ["completed" : completed], encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case let .success(value):
                break
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
}
