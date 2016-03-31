//
//  RestTableViewController.swift
//  
//
//  Created by Nathan Sass on 3/12/16.
//
//

import UIKit
import CoreData

class RestTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    var fetchResultController:NSFetchedResultsController!
    
    var restaurants:[Restaurant] = []
    
    var searchController:UISearchController!
    var searchResults:[Restaurant] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
        
        var fetchRequest   = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            var e: NSError?
            var result  = fetchResultController.performFetch(&e)
            restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            
            if result != true {
                println(e?.localizedDescription)
            }
        }
        
        /* Search Bar */
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView  = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        
        // Uncomment the following line to preserve selection between presentations
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    /* Search Bar: Provides rules for searching */
    func filterContentForSearchText(searchText: String) {
        searchResults = restaurants.filter({ ( restaurant: Restaurant) -> Bool in 265
            
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    
    /* Updates TableView: For after a restaurant is created */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!,
            atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType,
            newIndexPath: NSIndexPath!) {
            switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
            }
            restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
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
        
        if searchController.active {
            return searchResults.count
        } else {
            return self.restaurants.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
        indexPath) as! TableViewCell
        
                let restaurant      = (searchController.active) ? restaurants[indexPath.row] : restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text     = restaurant.type
//        cell.favorIconImageView.hidden = !restaurant.isVisited
        
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        if restaurants[indexPath.row].isVisited.boolValue {
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
        
        if ( self.restaurants[indexPath.row].isVisited.boolValue ) {
            menuMessage = "I haven't been here"
        }
        
        
        let isVisitedAction = UIAlertAction(title: menuMessage, style: .Default, handler: {
                (action:UIAlertAction!) -> Void in
                
                let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        
                if (self.restaurants[indexPath.row].isVisited.boolValue) {
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
        
            var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: {
                (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // Delete the row from the data source
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
                    let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as!
                        Restaurant
                    managedObjectContext.deleteObject(restaurantToDelete)
    
                    var e: NSError?
    
                    if managedObjectContext.save(&e) != true {
                        println("delete error: \(e!.localizedDescription)")
                    }
                }})
    
    
    
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
                    destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row]: restaurants[indexPath.row]
            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
                    return .LightContent
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */


    // Override to support conditional editing of the table view.
    /* Won't show swipabale buttons on search */
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        
        if searchController.active {
            return false
        } else {
            return true
        }
        
    }


 


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
