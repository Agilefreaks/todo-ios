//
//  NotesTableViewController.swift
//  Story List
//
//  Created by raluca on 15/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import UIKit
import Alamofire

class NotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NoteTableViewCellDelegate {

    
    
    var notes : [Note] = []
    var api = ApiService()
    var currentcell : Int = 0
   
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var tfNewNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        tfNewNote.text = "What needs to be done"
        tfNewNote.textColor = UIColor.lightGray
        self.notesTableView!.delegate = self
        self.notesTableView!.dataSource = self
     
        getData()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
      
    }

    func getData(){
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
    
    @IBAction func btnNoteCheckClick(_ sender: UIButton) {
        
        let isSelected = sender.isSelected
        if isSelected == true {
            if let image = UIImage(named: "Checkmarkempty.png"){
                sender.setImage(image, for: .normal)
                let id = notes[currentcell]._id
                api.updateToDo(id: id, completed: false)
            }
        } else {
            if let image = UIImage(named: "Checkmark.png"){
                sender.setImage(image, for: .normal)
                let id = notes[currentcell]._id
                api.updateToDo(id: id, completed: true)
            }
        }
        getData()
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func tfNewNoteEditingDidBegin(_ sender: UITextField) {
        if sender.textColor == UIColor.lightGray {
            sender.text = nil
            sender.textColor = UIColor.black
        }
    }
    
    @IBAction func tfNewNoteEditingDidEnd(_ sender: UITextField) {

        if let title = tfNewNote.text {
            api.postToDo(title: title)
        }
     
        getData()
        
        if (sender.text?.isEmpty)! {
                sender.text = "What needs to be done"
                sender.textColor = UIColor.lightGray
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
        print(index?.row)
        
        var status = notes[(index?.row)!].completed
        if status == true {
            if let image = UIImage(named: "Checkmarkempty.png"){
                sender.btnNoteCheck.setImage(image, for: .normal)
                let id = notes[(index?.row)!]._id
                api.updateToDo(id: id, completed: false)
            }
        } else {
            if let image = UIImage(named: "Checkmark.png"){
                sender.btnNoteCheck.setImage(image, for: .normal)
                let id = notes[(index?.row)!]._id
                api.updateToDo(id: id, completed: true)
            }
        }
        getData()
        //sender.btnNoteCheck.isSelected = !sender.btnNoteCheck.isSelected
        
    }
}
