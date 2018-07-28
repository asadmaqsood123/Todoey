//
//  ViewController.swift
//  Todoey
//
//  Created by Asad asadmaqsood on 26/07/2018.
//  Copyright © 2018 Asad Maqsood. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var  itemArray = [Item]()
    

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        
        
        

        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Buy Eggos"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Destroy Demogorgon"
        itemArray.append(newItem2)
        
            loadItem()
        
      
        
        
        
//        if  let items = defaults.array(forKey: "TodoListArray") as? [item] {
//            itemArray = items
//       }

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
        
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {

        var textField = UITextField()
        
        let alert =  UIAlertController(title: "Add New  Todoey Item" , message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!

            self.itemArray.append(newItem)
            
            self.saveItem()
            
            

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new  item "
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model  Manupulation  Methods
    func saveItem(){
        
        let encoder =  PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print("Error  encoding  item array, \(error)")
        }
        self.tableView.reloadData()

        
    }
    
    func loadItem(){
        if  let data =  try? Data(contentsOf: dataFilePath!){
       let decoder = PropertyListDecoder()
            do {
        itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding  item array, \(error)")
            }
        }
        
}
   


}

