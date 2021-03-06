//
//  ViewController.swift
//  TablerowDelete
//
//  Created by appinventiv on 24/08/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var citiesLabel: UILabel!
    
    @IBAction func deletBtn(_ sender: UIButton) {
        let temp = getCell(sender)
//        self.dataTableView.indexPath(for: temp)
        guard let indexPath = self.dataTableView.indexPath(for: temp) else {fatalError()}
        self.dataArray.remove(at: indexPath.row)
        dataTableView.reloadData()
        
    }
    
    //======= Data Array==========
    var dataArray = ["Delhi","Noida","Gurgaon","Mumbai","Saharanpur","Surat","Pune","Goa","Ahmedabad","hyderabad"]
    //==== Outlet of table View======
    @IBOutlet weak var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTableView.dataSource = self
        dataTableView.delegate = self
    }
}
////====== extension of ViewController class=====
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    // =======fn to Count no of rows======
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellData", for: indexPath) as? CellData else{
            fatalError()
        }
        
        cell.dataLabel.text = dataArray[indexPath.row]
        return cell
    }
    //======= swipe method============
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.dataArray.remove(at: editActionsForRowAt.row)
            self.dataTableView.deleteRows(at: [editActionsForRowAt], with: .automatic)
            
            print("delete button tapped")
        }
        delete.backgroundColor = .lightGray
        //====== Change Text button=========
        let change = UITableViewRowAction(style: .normal, title: "change") { action, index in
           let cell = self.dataTableView.cellForRow(at: editActionsForRowAt) as! CellData
            cell.dataLabel.text = "Cell Data Change"
            print("Change button tapped")
            
            
        }
        change.backgroundColor = .orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .blue
        
        return [share, change, delete]
    }
    
    func getCell(_ sender: UIButton) -> UITableViewCell {
        var cell: UIView = sender
        //----------jab tak cell superview nh milta-------- superview mil gaya
        while !(cell is CellData) {
            if let super_view = cell.superview {
                cell = super_view
            } else {}
            
            
        }
        guard let tableCell = cell as? CellData
            else
        {
            fatalError()
        }
        return tableCell
    }
    
    
}
    


// ====== cell class==========
class CellData: UITableViewCell{
    
    
   
    @IBOutlet weak var dataLabel: UILabel!
    
}
