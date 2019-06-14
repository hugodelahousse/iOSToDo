//
//  ToDoViewCell.swift
//  ToDo
//
//  Created by Hugo Delahousse on 08/06/2019.
//  Copyright © 2019 Hugo Delahousse. All rights reserved.
//

import UIKit

class ToDoViewCell: UITableViewCell {

    @IBOutlet weak var colorCircle: UIView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorCircle.layer.cornerRadius = colorCircle.frame.width / 2
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
