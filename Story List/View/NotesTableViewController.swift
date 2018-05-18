//
//  NotesTableViewController.swift
//  Story List
//
//  Created by raluca on 15/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import UIKit
import Alamofire

class NotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NoteTableViewCellDelegate, UITextFieldDelegate {
    var notes : [Note] = []
    var api = ApiService()
    var currentcell : Int = 0
    
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var tfNewNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        self.notesTableView.accessibilityIdentifier = "notesTableView"
        self.notesTableView!.delegate = self
        self.notesTableView!.dataSource = self
        
        tfNewNote.text = "What needs to be done"
        tfNewNote.textColor = UIColor.lightGray
        
        getToDos()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func getToDos(){
        api.getToDo(completionHandler: {data, error -> Void in
            if (data != nil) {
                self.notes = data!
                self.notesTableView.reloadData()
            } else {
                print("api.getData failed")
                print(error!)
            }
        })
    }
    
    func postToDo(title: String){
        api.postToDo(title: title, completionHandler: {data, error -> Void in
            if (data != nil) {
                self.notes.append(data!)
                self.notesTableView.reloadData()
                return 
            } else {
                print("api.getData failed")
                print(error!)
            }
        })
    }
    
    func updateToDoStatus(id: Oid, completed: Bool) -> String {
        var status : String = ""
        api.updateToDo(id: id, completed: completed, completionHandler: {data, error -> Void in
            if (data != nil) {
                status = data!
            } else {
                print("api.getData failed")
                print(error!)
            }
        })
        return status
    }
    
    @IBAction func tfNewNoteEditingDidBegin(_ sender: UITextField) {
        if sender.textColor == UIColor.lightGray {
            sender.text = nil
            sender.textColor = UIColor.black
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.delegate = self
        
        let row = indexPath.row
        let item = notes[row]
        let status = item.completed
        cell.lblNoteTitle.text = item.title
        
        if status == true {
            if let image = UIImage(named: "Checkmark.png"){
                cell.btnNoteCheck.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "Checkmarkempty.png"){
                cell.btnNoteCheck.setImage(image, for: .normal)
            }
        }
        
        return cell
    }
    
    func buttonWasTapped(sender: NoteTableViewCell) {
        let index = self.notesTableView.indexPath(for: sender)
        let rowIndex = index?.row
        let status = notes[rowIndex!].completed
        let updateReturnStatus : String
        if status == true {
            if let image = UIImage(named: "Checkmarkempty.png"){
                sender.btnNoteCheck.setImage(image, for: .normal)
                let id = notes[rowIndex!]._id
                updateReturnStatus = updateToDoStatus(id: id, completed: false)
                self.notesTableView.reloadData()
            }
        } else {
            if let image = UIImage(named: "Checkmark.png"){
                sender.btnNoteCheck.setImage(image, for: .normal)
                let id = notes[rowIndex!]._id
                updateReturnStatus = updateToDoStatus(id: id, completed: true)
                self.notesTableView.reloadData()
            }
        }
        getToDos()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let title = tfNewNote.text {
            postToDo(title: title)
            tfNewNote.text = nil
        }
        
        if (tfNewNote.text?.isEmpty)! {
            tfNewNote.text = "What needs to be done"
            tfNewNote.textColor = UIColor.lightGray
        }
        return true
    }
}
