//
//  NoteTableViewCell.swift
//  Story List
//
//  Created by raluca on 17/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import UIKit

protocol NoteTableViewCellDelegate: class {
    func buttonWasTapped(sender: NoteTableViewCell)
}

final class NoteTableViewCell: UITableViewCell {
    weak var delegate: NoteTableViewCellDelegate?
    
    @IBOutlet var btnNoteCheck: UIButton!
    @IBOutlet var lblNoteTitle: UILabel!
    
    @IBAction func btnNoteCheckClick(_ sender: UIButton) {
        delegate?.buttonWasTapped(sender: self)
    }
}
