//
//  ListTableViewController.swift
//  myAppUIKit
//
//  Created by Kaikai Liu on 2/6/21.
//

import UIKit
import os.log

class ListTableViewController: UITableViewController {
    
    var mydata = [NewsData] () //mutable array
    //var newdataitem:NewsData? = nil
    //var mydata2: [NewsData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data
        mydata = NewsData.defaultData
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mydata.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DataTableViewCell"
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DataTableViewCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let currentdata = mydata[indexPath.row]
        cell.name.text = currentdata.name
        cell.photo.image = currentdata.photo
        cell.title.text = currentdata.title
        cell.rating.text = String(repeating: "★", count: currentdata.rating)
        cell.rating.textColor = UIColor.orange
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mydata.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //saveMyData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
            case "AddItem":
                os_log("Adding a new data.", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
                guard let detailViewController = segue.destination as? DetailTableViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }

                guard let selectedCell = sender as? DataTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }

                guard let indexPath = tableView.indexPath(for: selectedCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                let selectedData = mydata[indexPath.row]
                detailViewController.newsdata = selectedData
            
        default:
            print("Unknow Segue Identifier")
//            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ScrollPostViewController, let prevdata=sourceViewController.newsdata {
            let newIndexPath = IndexPath(row: mydata.count, section: 0)
            mydata.append(prevdata)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        if let sourceViewController = sender.source as? DetailTableViewController, let prevdata=sourceViewController.newsdata {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //This code checks whether a row in the table view is selected.
                mydata[selectedIndexPath.row] = prevdata
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
        }
    }


}
