//
//  NotesTableViewController.swift
//  Story List
//
//  Created by raluca on 15/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import UIKit
import Alamofire

class NotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var notes : [Note] = []
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNotes()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let row = indexPath.row
        let item = notes[row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    // MARK: - TODO create class
    func getNotes(){
        let url  = "https://todo-backend-rails5-api.herokuapp.com/todos"
        Alamofire.request(url, method: .get).responseData { response in
            switch response.result {
            case let .success(value):
                
                let jsonDecoder = JSONDecoder()
                self.notes = try! jsonDecoder.decode([Note].self, from: value)
                self.notesTableView.reloadData()
            case let .failure(error):
                print(error)
            }
            
        }
    }
}
