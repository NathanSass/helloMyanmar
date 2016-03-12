//
//  ViewController.swift
//  HelloMyanmar
//
//  Created by Nathan Sass on 3/9/16.
//  Copyright (c) 2016 NathanSass. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "CafeLoisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh’s Chocolate", "Palomino Espresso",
        "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle &Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina","Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cellIdentifier = "Cell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            // Configure the cell...
            cell.textLabel!.text = restaurantNames[indexPath.row]
            return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func showMessage(){
        let alertController = UIAlertController(title: "Mangala BAHH", message: "CHitteeh", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }


}

