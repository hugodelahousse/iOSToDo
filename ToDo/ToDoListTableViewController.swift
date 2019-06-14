//
//  ToDoListTableViewController.swift
//  ToDo
//
//  Created by Hugo Delahousse on 08/06/2019.
//  Copyright © 2019 Hugo Delahousse. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    
    var items = [ToDoItem]()
    
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    
    
    func loadInitialData() {
        items = [
            ToDoItem(name: "Buy milk"),
            ToDoItem(name: "Learn Swift", color:  UIColor(rgb: 0x55efc4, alpha: 1)),
            ToDoItem(name: "Finish ToDo Project")
        ]
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
            
        loadInitialData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Only one section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows == Number of items
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListPrototypeCell", for: indexPath) as? ToDoViewCell else {
            fatalError("Invalid cell in TableView")
        }
        
        if indexPath.row >= items.count {
            fatalError("Invalid indexPath")
        }

        let item = items[indexPath.row]
        cell.title.text = item.name
        cell.colorCircle.backgroundColor = item.color
        cell.accessoryType = item.completed ? .checkmark : .none

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (isEditing) {
            return
        }
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row < items.count {
            let item = items[indexPath.row]
            item.completed = !item.completed
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print(indexPath.row)
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }

    
    @IBAction func editButton(_ sender: Any) {
        setEditing(!isEditing, animated: true)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if fromIndexPath.row < items.count && to.row < items.count {
            let item = items.remove(at: fromIndexPath.row)
            items.insert(item, at: to.row)
        }
    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    @IBAction func unwindToList(_ segue: UIStoryboardSegue) {
        if let source = segue.source as? CreateToDoViewController, let newItem = source.newItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                items[selectedIndexPath.row] = newItem
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                items.append(newItem)
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if sender as? UIBarButtonItem === addItemButton {
            return true
        }
        return self.isEditing
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
            case "AddItem":
                break
            case "ShowDetail":
                guard let detailView = segue.destination as? CreateToDoViewController else {
                    fatalError("Bad destination for ShowDetail")
                }
                
                guard let selectedItem = sender as? ToDoViewCell else {
                    fatalError("Bad sneder for ShowDetail")
                }
            
                detailView.newItem = ToDoItem(name: selectedItem.title.text ?? "", color: selectedItem.colorCircle.backgroundColor)
            
            default:
                fatalError("Unknown Segue")
        }
    }
 

}
