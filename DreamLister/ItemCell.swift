//
//  ItemCell.swift
//  DreamLister
//
//  Created by James Volmert on 9/12/16.
//  Copyright © 2016 James Volmert. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

  

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
    }
    
}
