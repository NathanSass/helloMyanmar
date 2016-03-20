//
//  RestTableViewController.swift
//  
//
//  Created by Nathan Sass on 3/12/16.
//
//

import UIKit

class RestTableViewController: UITableViewController {

    var restaurants:[Restaurant] = [ Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend.jpg", isVisited: false), Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei.jpg", isVisited: false), Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha.jpg", isVisited: false), Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl.jpg", isVisited: false), Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster.jpg", isVisited: false), Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image:"forkeerestaurant.jpg", isVisited: false), Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier.jpg", isVisited: false), Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery.jpg", isVisited: false), Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate.jpg", isVisited: false), Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palominoespresso.jpg", isVisited: false), Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate.jpg", isVisited: false), Restaurant(name: "Traif", type: "American", location: "New York", image: "traif.jpg", isVisited: false), Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "NewYork", image: "grahamavenuemeats.jpg", isVisited: false), Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf.jpg", isVisited: false), Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves.jpg", isVisited: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.restaurants.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
        indexPath) as! TableViewCell
        
        let restaurant      = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(named: restaurant.image)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text     = restaurant.type
//        cell.favorIconImageView.hidden = !restaurant.isVisited
        
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        if restaurants[indexPath.row].isVisited {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        // Create an option meny as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .ActionSheet)
    
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    
        optionMenu.addAction(cancelAction)
    
    
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
    
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: UIAlertActionStyle.Default, handler: callActionHandler)
    
        optionMenu.addAction(callAction)
        
        var menuMessage = "I've been here"
        
        if ( self.restaurants[indexPath.row].isVisited ) {
            menuMessage = "I haven't been here"
        }
        
        
        let isVisitedAction = UIAlertAction(title: menuMessage, style: .Default, handler: {
                (action:UIAlertAction!) -> Void in
                
                let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        
                if (self.restaurants[indexPath.row].isVisited) {
                    self.restaurants[indexPath.row].isVisited = false
                    cell?.accessoryType =  .None
                } else {
    
                    self.restaurants[indexPath.row].isVisited = true
                    cell?.accessoryType = .Checkmark
                }
    
        })
    
        optionMenu.addAction(isVisitedAction)
    
    
        // Display the menu
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.restaurants.removeAtIndex(indexPath.row)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
//        self.tableView.reloadData()
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject] {
            
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
            title: "Share",
            handler: {

                (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in

                let shareMenu      = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
        
                let twitterAction  = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
        
                let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
        
                let emailAction    = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default, handler: nil)
        
                let cancelAction   = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
                shareMenu.addAction(twitterAction)
                shareMenu.addAction(facebookAction)
                shareMenu.addAction(emailAction)
                shareMenu.addAction(cancelAction)
                self.presentViewController(shareMenu, animated: true, completion: nil)
            } )
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
            title: "Delete",
            handler: {
                (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
        
                // Delete the row from the data source
                self.restaurants.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } )
    
//        shareAction.backgroundColor  = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
//        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        shareAction.backgroundColor  = UIColor.blueColor()
        deleteAction.backgroundColor = UIColor.redColor()
    
        return [deleteAction, shareAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as! DetailViewController
                    destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

 


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
