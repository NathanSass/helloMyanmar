//
//  DetailViewController.swift
//  
//
//  Created by Nathan Sass on 3/18/16.
//
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var restaurantImageView:UIImageView!
    var restaurantImage:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restaurantImageView.image = UIImage(named: restaurantImage)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
