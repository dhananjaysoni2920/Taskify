//
//  ViewController.swift
//  Taskify
//
//  Created by Dhananjay Soni on 22/05/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var MyTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Tasklist = UserDefaults.standard.stringArray(forKey: "Tasklist") ?? []
        MyTable.dataSource = self
        MyTable.delegate = self
        addButton.layer.cornerRadius = 20
        
                
    }
    
    
    @IBAction func addButton(_ sender: Any) {
    addTaskAlert()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tasklist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCustomCell
        
        cell.myCellLabel.text = Tasklist[indexPath.row]
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            var updatedtasklist = UserDefaults.standard.stringArray(forKey: "Tasklist") ?? []
            updatedtasklist.remove(at: indexPath.row)
            UserDefaults.standard.setValue(updatedtasklist, forKey: "Tasklist")
            Tasklist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }
    
    func addTaskAlert(){
        let alert = UIAlertController(title: "Enter Details", message: "Please Enter Task Details", preferredStyle: .alert)
        
        alert.addTextField{field in
            field.placeholder = "Enter Item"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self](_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    DispatchQueue.main.async {
                        var currentTasklist = UserDefaults.standard.stringArray(forKey: "Tasklist") ?? []
                        currentTasklist.append(text)
                        UserDefaults.standard.setValue(currentTasklist, forKey: "Tasklist")
                        Tasklist.append(text)
                        self?.MyTable.reloadData()
                    }
                }
                
                else{
                    return
                }
            }
        }))
        present(alert, animated: true)
}

}


