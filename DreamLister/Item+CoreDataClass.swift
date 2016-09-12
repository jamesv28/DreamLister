//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by James Volmert on 9/12/16.
//  Copyright © 2016 James Volmert. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        //  when creating the date, create the current date
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
