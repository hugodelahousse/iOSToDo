//
//  Color.swift
//  ToDo
//
//  Created by Hugo Delahousse on 09/06/2019.
//  Copyright © 2019 Hugo Delahousse. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat(((rgb >> 16) & 0xFF)) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: alpha
        )
    }
}

struct Color {
    let name: String
    let value: UIColor?
    
    init(name: String, value: UIColor?) {
        self.name = name
        self.value = value
    }
}
