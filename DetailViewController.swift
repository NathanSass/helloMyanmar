//
//  DetailViewController.swift
//  
//
//  Created by Nathan Sass on 3/18/16.
//
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var restaurantImageView:UIImageView!
    var restaurantImage:String!
    var restaurant:Restaurant!
    @IBOutlet var tableView:UITableView!
    
//    @IBOutlet var restaurantNameView:UILabel!
//    var restaurantName:String!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.restaurantImageView.image = UIImage(named: restaurant.image)
        
        title = self.restaurant.name
        
//        self.tableView.separatorColor = UIColor(red:240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0,alpha: 0.8)
//        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailTableViewCell
            // Configure the cell...
            switch indexPath.row {
                case 0:
                    cell.fieldLabel.text = "Name"
                    cell.valueLabel.text = restaurant.name
                case 1:
                    cell.fieldLabel.text = "Type"
                    cell.valueLabel.text = restaurant.type
                case 2:
                    cell.fieldLabel.text = "Location"
                    cell.valueLabel.text = restaurant.location
                case 3:
                    cell.fieldLabel.text = "Been here"
                    cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I’ve been here before" : "No"
                default:
                    cell.fieldLabel.text = ""
                    cell.valueLabel.text = ""
            }
            cell.backgroundColor = UIColor.clearColor()
        
            return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
