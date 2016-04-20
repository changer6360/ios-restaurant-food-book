//
//  AddRestaurantController.swift
//  Food Book
//
//  Created by Tihomir Videnov on 4/16/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit
import CoreData


class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView:UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var locationTextField:  UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var restaurant: Restaurant!
    
    var isVisited = true

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
 

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        
        //Adding constaints programmatically
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute:NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem:imageView.superview, attribute: NSLayoutAttribute.Leading, multiplier: 1,constant: 0)
        leadingConstraint.active = true
        
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute:NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem:imageView.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1,constant: 0)
        trailingConstraint.active = true
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute:NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:imageView.superview, attribute: NSLayoutAttribute.Top,multiplier: 1, constant: 0)
        topConstraint.active = true
        
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute:NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:imageView.superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1,constant: 0)
        bottomConstraint.active = true

        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButton(sender: UIBarButtonItem){
        let name = nameTextField.text
        let type = typeTextField.text
        let location = locationTextField.text
        let phone = phoneTextField.text
        
        //Validating the input fields
        if name == "" || type == "" || location == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are requred.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
//        //Print input data to console
//        print("Name: \(name)")
//        print("Type: \(type)")
//        print("Location: \(location)")
//        print("Have you been here: \(isVisited)")
        
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
            restaurant.name = name!
            restaurant.type = type!
            restaurant.location = location!
            restaurant.phoneNumber = phone!
            if let restaurantImage = imageView.image {
                restaurant.image = UIImagePNGRepresentation(restaurantImage)
            }
         restaurant.isVisited = isVisited
            
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
                return
            }
        }
        
        
        
        
        //Dismiss the view controller
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        // Yes button clicked
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
            noButton.backgroundColor = UIColor.grayColor()
        } else if sender == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        }
    }
    
    
        
    
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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


