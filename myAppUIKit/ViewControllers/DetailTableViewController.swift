//
//  DetailTableViewController.swift
//  myAppUIKit
//
//  Created by Kaikai Liu on 2/7/21.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var tilename: UILabel!
    @IBOutlet weak var storylabel: UILabel!
    @IBOutlet weak var authorname: UILabel!
    
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var ratingvalue: UILabel!
    
    var newsdata: NewsData?
    
    @IBAction func submitRating(_ sender: UIButton) {
    }
    @IBAction func weblink(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))
        //load input data
        if let newsdata = newsdata {
            headerView.imageView.image = newsdata.photo//UIImage(named: "Image1")
            tilename.text = newsdata.title
            storylabel.text = newsdata.story
            authorname.text = newsdata.name
            ratingvalue.text = String(repeating: "★", count: newsdata.rating)
//            locationlabel.text = "latitude : \(String(describing: newsdata.coordinate?.latitude ?? "")) - longitude : \(String(describing: newsdata.coordinate?.longitude ?? ""))"
        }
        self.tableView.tableHeaderView = headerView
        self.tableView.rowHeight = UITableView.automaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .blue//.white  //change the back button color
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//if not using Tableview, need to conform to UIScrollViewDelegate
extension DetailTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! StretchyTableHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}
