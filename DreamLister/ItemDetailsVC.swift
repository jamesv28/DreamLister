//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by James Volmert on 9/14/16.
//  Copyright © 2016 James Volmert. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imagePickerBtn: UIButton!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var imgPick: UIImageView!
    
    
    var itemToEdit: Item?
    var stores = [Store]()

    // adding a gesture
    let pinchRec = UIPinchGestureRecognizer()


    override func viewDidLoad() {
        
        super.viewDidLoad()

        imagePickerBtn.isAccessibilityElement = true
        imagePickerBtn.accessibilityLabel = "Click to select an image"
        // Do any additional setup after loading the view.

        //  add gesture recognizer for table view
//        storePicker.addTarget(self, action: "pinchedView")
//        pinchView.userInteractionEnabled = true
//        pinchView.multipleTouchEnabled = true
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        // add delegate and data protocol
        storePicker.dataSource = self
        storePicker.delegate = self
        
        //  instantiate hte UI image picker controller
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // create stores
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Micro Center"
        let store3 = Store(context: context)
        store3.name = "Tesla Dealership"
        let store4 = Store(context: context)
        store4.name = "Mall"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "Cherry Creek Mall"
         ad.saveContext()
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }  // end of viewDidLoad
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
        
    } // get the title for section
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
        
    }   //  number of rows in the picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }   // number of columns in a row
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //  code goes here
    }   // what to do when we select a row

    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }
        catch {
            
            //  handle the error
        }
    
    }  //   get stores from core data

    @IBAction func savePress(_ sender: AnyObject) {
        //let item = Item(context: context)
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = imgPick.image
        
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }

        if let price = priceField.text {
            //  change and manipulate the pries field: here is how we do it
            item.price = (price as NSString).doubleValue
        }

        if let details = detailsField.text {
            item.details = details
        }

        //  get the relationship to the store
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]

        ad.saveContext()

        // go back to the main screen after saving
        _ = navigationController?.popViewController(animated: true)


    }
    
    func loadItemData() {

        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            imgPick.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {

                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)


            }
        }
    }   // end of loading item data
    
    @IBAction func deletePressed(_ sender: AnyObject) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
            
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: AnyObject) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // you have to go through the dictionary now to select an image
        if let img = info[UIImagePickerControllerOriginalImage] as?  UIImage {
            imgPick.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // list of accessibility functions to use
    //  var isAccessibilityElement: Bool
    //  var accessibilityLabel: String?
    
    //  var accessibilityHint: String?
    //  var accessibilityValue: String?
    //  var accessibilityTraits: UIAccessibilityTraits
    //  var accessibilityFrame: CGFloat
    
    
} // end of item details controller
