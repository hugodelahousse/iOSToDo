//
//  ToDoItem.swift
//  ToDo
//
//  Created by Hugo Delahousse on 08/06/2019.
//  Copyright © 2019 Hugo Delahousse. All rights reserved.
//

import UIKit

class ToDoItem {
    var name: String
    var completed: Bool
    var color: UIColor?
    
    init(name: String, color: UIColor? = nil) {
        self.name = name
        self.color = color
        self.completed = false
    }
}
