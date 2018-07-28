//
//  ViewController.swift
//  Todoey
//
//  Created by Asad asadmaqsood on 26/07/2018.
//  Copyright © 2018 Asad Maqsood. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var  itemArray = [item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = item()
        newItem1.title = "Buy Eggos"
        itemArray.append(newItem1)
        
        let newItem2 = item()
        newItem2.title = "Destroy Demogorgon"
        itemArray.append(newItem2)
        
        
        
      
        
        
        
//        if  let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//            print(items)
//        }

    }
    
    //MARK - Tableview  Datasource  Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item  = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condtion ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {

        var textField = UITextField()
        
        let alert =  UIAlertController(title: "Add New  Todoey Item" , message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = item()
            newItem.title = textField.text!
            
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new  item "
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
   


}

