//
//  CellVC.swift
//  Food Book
//
//  Created by Tihomir Videnov on 4/6/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit
import CoreData


class CellVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var restaurants:[Restaurant] = []
    
    var fetchResultController: NSFetchedResultsController!
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            } catch {
                print(error)
            }
            
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject
        anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type:
        NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation:
                    .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation:
                    .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //hiding the nav bar
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIndetifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndetifier, forIndexPath: indexPath) as! CustomCell

        // Configure the cell...
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(data: restaurants[indexPath.row].image!)
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        //cell.thumbnailImageView.layer.cornerRadius = 50.0
        //cell.thumbnailImageView.clipsToBounds = true
        
        
        if ((restaurants[indexPath.row].isVisited?.boolValue) != nil) {
            cell.accessoryType = .Checkmark
        }else {
        cell.accessoryType = .None
        }
        
        return cell
        
            }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        //Creating an option menu with action style sheet - Varian 1
//        let optionMenu = UIAlertController(title: nil, message: "Hey, what do you want to do?", preferredStyle: .Alert)
//        
//        
//        //Adding actions to the menu
//        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        
//        
//        
//        
//        
//        //Create additional alert - Variant 2
//        let callActionHandler = { (action:UIAlertAction!) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//            self.presentViewController(alertMessage, animated: true, completion: nil)
//        }
//        
//        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)" , style: UIAlertActionStyle.Default, handler: callActionHandler)
//        optionMenu.addAction(callAction)
//        
//        
//        
//        // Another way for creatinig an action button - Variant 3
//        let isVisitedTitle = (restaurantIsVisited[indexPath.row]) ? "I've not been here" : "I've been here"
//        let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .Default, handler: {
//            (action:UIAlertAction!) -> Void in
//            
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//           
//            self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
//            cell?.accessoryType = (self.restaurantIsVisited[indexPath.row]) ? .Checkmark : .None
//        })
//        optionMenu.addAction(isVisitedAction)
//        
//        
//        //Display the menu
//        self.presentViewController(optionMenu, animated: true, completion: nil)
//        
//        //To deselect the row when action is choosen
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//        
//        
//        
////        //Adding second test button
////        let secondActionHandler = { (action:UIAlertAction!) -> Void in
////            let alertMessage = UIAlertController(title: "Another test button", message: "Just testing the additional button", preferredStyle: .Alert)
////            alertMessage.addAction(UIAlertAction(title: "GOOD", style: .Default, handler: nil))
////            self.presentViewController(alertMessage, animated: true, completion: nil)
////        }
////        
////        let callAction2 = UIAlertAction(title: "Blah", style: UIAlertActionStyle.Default, handler: secondActionHandler)
////        optionMenu.addAction(callAction2)
//        
//        
//        
//        
//    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            //Delete the row from the data source
            restaurants.removeAtIndex(indexPath.row)

            }
        
        //tableView.reloadData()
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        
//        print("Total item: \(restaurantNames.count)")
//            for name in restaurantNames {
//                print(name)
//                
//                
//       }
   
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath
        indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.Default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Just checking in at " +
                    self.restaurants[indexPath.row].name
                if let imageToShare = UIImage(data:
                    self.restaurants[indexPath.row].image!) {
                    let activityController = UIActivityViewController(activityItems:
                        [defaultText, imageToShare], applicationActivities: nil)
                    self.presentViewController(activityController, animated: true,
                        completion: nil)
                } })
        // Delete button
        let deleteAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.Default, title: "Delete",handler: { (action,
                indexPath) -> Void in
                // Delete the row from the database
                
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                    let restaurantDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                    managedObjectContext.deleteObject(restaurantDelete)
                    
                    
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
        })
        
        //Defining custom color to the row action buttons
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0,
                                              blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
                                               
                                               
        return [deleteAction, shareAction]
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! CellDetailVC
               
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
