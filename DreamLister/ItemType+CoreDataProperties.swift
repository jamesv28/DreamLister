//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by James Volmert on 9/12/16.
//  Copyright © 2016 James Volmert. All rights reserved.
//

import Foundation
import CoreData

extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
