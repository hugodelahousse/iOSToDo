//
//  CreateToDoViewController.swift
//  ToDo
//
//  Created by Hugo Delahousse on 09/06/2019.
//  Copyright © 2019 Hugo Delahousse. All rights reserved.
//

import UIKit

class CreateToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let colors = [
        Color(name: "None", value: nil),
        Color(name: "Light Greenish Blue", value: UIColor(rgb: 0x55efc4, alpha: 1)),
        Color(name: "Faded Poster", value: UIColor(rgb: 0x81ecec, alpha: 1)),
        Color(name: "Green Darner Tail", value: UIColor(rgb: 0x74b9ff, alpha: 1)),
        Color(name: "Shy Moment", value: UIColor(rgb: 0xa29bfe, alpha: 1)),
        Color(name: "Sour Lemon", value: UIColor(rgb: 0xffeaa7, alpha: 1)),
        Color(name: "First Date", value: UIColor(rgb: 0xfab1a0, alpha: 1)),
        Color(name: "Pink Glamour", value: UIColor(rgb: 0xff7675, alpha: 1)),
        Color(name: "Pico-8 Pink", value: UIColor(rgb: 0xfd79a8, alpha: 1)),
    ]

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var colorPicker: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var newItem: ToDoItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self
        colorPicker.dataSource = self
        
        if newItem != nil {
            textField.text = newItem?.name
            if let i = colors.firstIndex(where: {$0.value == newItem?.color}) {
                let path = IndexPath(row: i, section: 0)
                colorPicker.reloadData()
                colorPicker.cellForRow(at: path)?.accessoryType = .checkmark
                colorPicker.selectRow(at: path, animated: false, scrollPosition: .none)
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ColorPickerCell", for: indexPath) as? ToDoViewCell else {
            fatalError("Invalid cell in TableView")
        }
        
        if indexPath.row >= colors.count {
            return cell
        }
        
        let color = colors[indexPath.row]
        
        cell.textLabel?.text = color.name
        cell.colorCircle.backgroundColor = color.value
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    // MARK: - Navigation

    @IBAction func cancel(_ sender: Any) {
        
        let addingItem = presentingViewController is UINavigationController
        if addingItem {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIBarButtonItem, button == saveButton {
            
            var color: UIColor? = nil
            if colorPicker.indexPathForSelectedRow != nil && colorPicker.indexPathForSelectedRow!.row < colors.count {
                color = colors[colorPicker.indexPathForSelectedRow!.row].value
            }
            
            newItem = ToDoItem(
                name: textField.text ?? "",
                color: color
            )
        }
    }
}
