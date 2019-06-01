//
//  EditComicBookViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/12/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class EditComicBookViewController: UITableViewController {
    
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var eraLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var legacyIssueNumberLabel: UILabel!
    @IBOutlet weak var variantLabel: UILabel!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var purchasePriceLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var sellDateLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var comicBookCollection: ComicBookCollection!
    var currentIdentifier: String!
    var image: UIImage?
    var imageHeight: CGFloat = 260
    var listPickerKind = "Publisher"
    
    // MARK:- Two kinds of data changes...
    
    /// Tracks changes to navigational related properties.
    ///
    /// - _True_: User changed publisher, era, series, issue number, and/or variant info
    ///   and so now the navigation hierarchy needs to be updated and the back button
    ///   should be disabled.
    ///   Save button should be used to exit view to the part of
    ///   the view hierarchy that didn't change.
    /// - _False_: Back button ok to use but might need to save data.
    ///   Save button does what back button does.
    var navigationBreakingChange = false
    
    /// Tracks changes to non-navigational related properties.
    ///
    /// - _True_: User changed non-navigational related properties and so the back button can be
    /// used safely but data has to saved first. Save button does what the back button does.
    /// - _False_: User didn't change non-navigational related properties.
    ///   Back button can be safely used if no navigational changes were made.
    ///   Save button does what back button does.
    var dataPropertyChange = false
    
    var transactionInfo: CKTransaction?
    
    // MARK:-
    
    let photoSection = 1
    let photoRow = 0
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check for data changes that break navigation
        saveButton.isEnabled = navigationBreakingChange
        navigationItem.setHidesBackButton(navigationBreakingChange, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check for data changes that break navigation
        transactionInfo = nil
        saveButton.isEnabled = navigationBreakingChange
        navigationItem.setHidesBackButton(navigationBreakingChange, animated: true)
        
        let currentComicBook = comicBookCollection.comicBook(from: currentIdentifier)
        
        title = "#\(currentComicBook?.comic.issueNumber ?? "Edit Comicbook")\(currentComicBook?.comic.variant ?? "")"
        
        publisherLabel.text = currentComicBook?.publisherName
        eraLabel.text = currentComicBook?.seriesEra
        seriesLabel.text = currentComicBook?.seriesName
        issueNumberLabel.text = currentComicBook?.comic.issueNumber
        
        if let legacyIssueNumberText = currentComicBook?.comic.legacyIssueNumber {
            if legacyIssueNumberText.isEmpty {
                legacyIssueNumberLabel.text = "none"
            } else {
                legacyIssueNumberLabel.text = legacyIssueNumberText
            }
        }
        
        variantLabel.text = currentComicBook?.comic.variant
        
        conditionLabel.text = currentComicBook?.book.condition
        purchasePriceLabel.text = currentComicBook?.book.purchasePriceText
        purchaseDateLabel.text = currentComicBook?.book.purchaseDateText
        sellPriceLabel.text = currentComicBook?.book.sellPriceText
        sellDateLabel.text = currentComicBook?.book.sellDateText
    }
    
    // MARK:- Table View
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == photoSection && indexPath.row == photoRow {
            tableView.deselectRow(at: indexPath, animated: true)
            pickPhoto()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let currentComicBook = comicBookCollection.comicBook(from: currentIdentifier)
        
        func configureStandardPicker(kind: String, pickerList: [String], selectedItem: String, noneButtonVisible: Bool) {
            listPickerKind = kind
            let picker = segue.destination as! StandardPicker
            picker.itemList = pickerList
            picker.pickerTitle = listPickerKind
            picker.selectedItemName = selectedItem
            picker.hintText = currentComicBook!.identifier
            picker.noneButtonVisible = noneButtonVisible
            
            // save info about this transaction
            transactionInfo = CKTransaction(fieldName: listPickerKind, inputValue: selectedItem, outputValue: "")
        }
        
        switch segue.identifier {
        case "ChoosePublisherSegue":
            let pl = comicBookCollection.publisherNames.sorted()
            let si = currentComicBook?.comic.publisher
            configureStandardPicker(kind: "Publisher", pickerList: pl, selectedItem: si!, noneButtonVisible: false)
            
        case "ChooseSeriesSegue":
            let pl = comicBookCollection.seriesNames.sorted()
            let si = currentComicBook?.comic.series
            configureStandardPicker(kind: "Series", pickerList: pl, selectedItem: si!, noneButtonVisible: false)
            
        case "ChooseEraSegue":
            let pl = comicBookCollection.eras
            let si = currentComicBook?.seriesEra
            configureStandardPicker(kind: "Era", pickerList: pl, selectedItem: si!, noneButtonVisible: false)
            
        case "ChooseIssueNumber":
            let pl = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook?.comic.issueNumber
            configureStandardPicker(kind: "Issue Number", pickerList: pl, selectedItem: si!, noneButtonVisible: false)
            
        case "ChooseLegacyIssueNumber":
            let pl = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook?.comic.legacyIssueNumber
            configureStandardPicker(kind: "Legacy Issue Number", pickerList: pl, selectedItem: si!, noneButtonVisible: true)
            
        case "ChooseConditionSegue":
            let pl = comicBookCollection.allPossibleConditions
            let si = currentComicBook?.book.condition
            configureStandardPicker(kind: "Condition", pickerList: pl, selectedItem: si!, noneButtonVisible: false)
            
        case "EditVariantSignifierSegue":
            let controller = segue.destination as! PickerAddViewController
            listPickerKind = "Variant Info"
            controller.pickerTitle = listPickerKind
            controller.hintText = currentComicBook!.identifier
            if let v = currentComicBook?.comic.variant {
                controller.selectedItemName = v
                // save info about this transaction
                transactionInfo = CKTransaction(fieldName: listPickerKind, inputValue: v, outputValue: "")
            }
            
        case "EditPurchasePriceSegue":
            let controller = segue.destination as! PickerAddViewController
            listPickerKind = "Purchase Price"
            controller.pickerTitle = listPickerKind
            controller.hintText = currentComicBook!.identifier
            if let price = currentComicBook?.book.purchasePriceText {
                controller.selectedItemName = price
            }
            
        case "EditSalesPriceSegue":
            let controller = segue.destination as! PickerAddViewController
            listPickerKind = "Sales Price"
            controller.pickerTitle = listPickerKind
            controller.hintText = currentComicBook!.identifier
            if let price = currentComicBook?.book.sellPriceText {
                controller.selectedItemName = price
            }
            
        case "EditPurchaseDateSegue":
            let controller = segue.destination as! PickerDateViewController
            listPickerKind = "Purchase Date"
            controller.pickerTitle = listPickerKind
            controller.hintText = currentComicBook!.identifier
            if let purchaseDate = currentComicBook?.book.purchaseDate {
                controller.selectedItemDate = purchaseDate
            } else {
                controller.selectedItemDate = Date()
            }
            
        case "EditSalesDateSegue":
            let controller = segue.destination as! PickerDateViewController
            listPickerKind = "Sales Date"
            controller.pickerTitle = listPickerKind
            controller.hintText = currentComicBook!.identifier
            if let sellDate = currentComicBook?.book.sellDate {
                controller.selectedItemDate = sellDate
            } else {
                controller.selectedItemDate = Date()
            }
            
        default:
            assert(true, "unsupported seque in EditComicBookViewController")
        }
    }
    
    // MARK:- Unwind/Exit Segues
    
    // TODO: Update data if changed
    // TODO: Detect navigtaion breaking change and prevent it from crashing app. If the currentComicBook can't be found because the publisher, series, issue number, or variant info changed, then alert user and pop back to the SeriesTableViewController.
    // TODO: Data validation
    
    // Unwind/exit segue from AddItemViewController
    @IBAction func addItemDidEditItem(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerAddViewController
        
        guard let newText = controller.newItemTextField.text else {
            return
        }
        
        if controller.pickerTitle.contains("Variant") {
            navigationBreakingChange = true
            variantLabel.text = newText
            
        } else if controller.pickerTitle.contains("Purchase") {
            
            if newText.isEmpty {
                purchasePriceLabel.text = "none"
            } else {
                purchasePriceLabel.text = newText
            }
            
        } else if controller.pickerTitle.contains("Sales") {
            
            if newText.isEmpty {
                sellPriceLabel.text = "none"
            } else {
                sellPriceLabel.text = newText
            }
        }
        
        dataPropertyChange = true
    }
    
    // Unwind/exit segue from list picker to edit comic book view controller.
    @IBAction func listPickerDidPickItem(_ segue: UIStoryboardSegue) {
        
        // TODO: Back button on AddItemViewController doesn't trigger listPickerDidPickItem when an item is added
        
        let controller = segue.source as! PickerTableViewController
        let _ = comicBookCollection.comicBook(from: currentIdentifier)
        
        if listPickerKind == "Publisher" {
            publisherLabel.text = controller.selectedItemName
        } else if listPickerKind == "Series" {
            seriesLabel.text = controller.selectedItemName
        } else if listPickerKind == "Condition" {
            conditionLabel.text = controller.selectedItemName
        }
    }
    
    // Unwind/exit segue from dial picker to edit comic book view controller.
    @IBAction func dialPickerDidPickItem(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerDialViewController
        
        if listPickerKind == "Era" {
            eraLabel.text = controller.selectedItemName
        } else if listPickerKind == "Issue Number" {
            issueNumberLabel.text = controller.selectedItemName
        } else if listPickerKind == "Legacy Issue Number" {
            
            if controller.selectedItemName.isEmpty {
                legacyIssueNumberLabel.text = "none"
            } else {
                legacyIssueNumberLabel.text = controller.selectedItemName
            }
            
        }
    }
    
    @IBAction func datePickerDidPickDate(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerDateViewController
        
        if listPickerKind == "Purchase Date" {
            if controller.selectedItemName.isEmpty {
                purchaseDateLabel.text = "none"
            } else {
                purchaseDateLabel.text = controller.selectedItemName
            }
        } else if listPickerKind == "Sales Date" {
            if controller.selectedItemName.isEmpty {
                sellDateLabel.text = "none"
            } else {
                sellDateLabel.text = controller.selectedItemName
            }
        }
    }
}

extension EditComicBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK:- Image Helper Methods
    
    func show(image: UIImage) {
        coverImage.image = image
        coverImage.isHidden = false
        let imageRatio = image.size.height / image.size.width
        let imageWdith: CGFloat = 260
        imageHeight = imageWdith * imageRatio
        tableView.reloadData()
    }
    
    func pickPhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actCancel)
        
        let actPhoto = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.takePhotoWithCamera()
        })
        alert.addAction(actPhoto)
        
        let actLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
            self.choosePhotoFromLibrary()
        })
        alert.addAction(actLibrary)
        
        present(alert, animated: true, completion: nil)
    }
    
    func createImagePicker(kind: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = kind
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.view.tintColor = view.tintColor
        return imagePicker
    }
    
    func takePhotoWithCamera() {
        let imagePicker = createImagePicker(kind: .camera)
        present(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = createImagePicker(kind: .photoLibrary)
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK:- Image Picker Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let theImage = image {
            show(image: theImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

