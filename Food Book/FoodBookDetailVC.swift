//
//  CellDetailVC.swift
//  Food Book
//
//  Created by Tihomir Videnov on 4/9/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class CellDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var restaurantImageView: UIImageView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ratingButton:UIButton!
    
    @IBAction func close(segue:UIStoryboardSegue) {
        
        if let reviewViewController = segue.sourceViewController as?
            ReviewViewController {
            if let rating = reviewViewController.rating {
                restaurant.rating = rating
                ratingButton.setImage(UIImage(named: rating), forState:
                    UIControlState.Normal)
                
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                    
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
                
            }
        }
    }
    
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()

        //enabling self sizing cells
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //setting the background of the table view
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
        restaurantImageView.image = UIImage(data: restaurant.image!)
        
        
        //Setting the name of the navigation bar = selected restaurant name
        title = restaurant.name
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destinationViewController as! MapViewController
            destinationController.restaurant = restaurant
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //showing the nav bar because we need it here
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! DetailTableViewCell
        
        
        
        
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
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phoneNumber
        case 4:
            cell.fieldLabel.text = "Been here"
            if let isVisited = restaurant.isVisited?.boolValue {
                cell.valueLabel.text = isVisited ? "Yes, I've  been here before" : "No" }
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    
    }
        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


