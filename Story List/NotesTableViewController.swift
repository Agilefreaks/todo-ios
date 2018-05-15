//
//  NotesTableViewController.swift
//  Story List
//
//  Created by raluca on 15/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import UIKit
import Alamofire

class NotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var note : Note?
    var oid : Oid?
    var notes : [Note] = []
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func getNotes(){
        let url  = "https://todo-backend-rails5-api.herokuapp.com/todos"
        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case let .success(value):
                for item in value as! [[AnyHashable : Any]] {
                    
                    let idDictionary = item["_id"] as! [AnyHashable : Any]
                    let oid = Oid(oid: idDictionary["$oid"] as! String )
                    
                    let note = Note(id: oid, title: item["title"] as! String, completed: item["completed"] as! Bool, created_at: item["created_at"] as! String, order: item["order"] as! Int, updated_at: item["updated_at"] as! String, url: item["url"] as! String)
                    self.notes.append(note)
                    
                    self.notesTableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
            
        }
    }
}
