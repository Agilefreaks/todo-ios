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
    
    var notes : [Note] = []
    var api = ApiService()
   
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var tfNewNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            }
        } else {
            if let image = UIImage(named: "Checkmark.png"){
                sender.setImage(image, for: .normal)
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let row = indexPath.row
        let item = notes[row]
        let status = item.completed
        let lblNote = cell.contentView.viewWithTag(1) as? UILabel
        
        lblNote?.text = item.title
    
        if let btnNoteCheck = cell.contentView.viewWithTag(2) as? UIButton {
           // var attrString = NSObject.new; NSAttributedString(string: "The text", attributes: NSUnderlineStyle.Single)
            
            btnNoteCheck.addTarget(self, action: #selector(btnNoteCheckClick(_ :)), for: .touchUpInside)
            btnNoteCheck.tag = row
            
            if status == true {
                if let image = UIImage(named: "Checkmark.png"){
                    btnNoteCheck.setImage(image, for: .normal)
                }
            } else {
                if let image = UIImage(named: "Checkmarkempty.png"){
                    btnNoteCheck.setImage(image, for: .normal)
                   // lblNote?.attributedText = attributeString
                }
            }
        }
        
        return cell
    }
    
    
}
