//
//  Restaurant.swift
//  Food Book
//
//  Created by Tihomir Videnov on 4/10/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import Foundation
import CoreData


class Restaurant:NSManagedObject {
    @NSManaged var name:String
    @NSManaged var type:String
    @NSManaged var location:String
    @NSManaged var phoneNumber:String?
    @NSManaged var image:NSData?
    @NSManaged var isVisited:NSNumber?
    @NSManaged var rating:String?

}