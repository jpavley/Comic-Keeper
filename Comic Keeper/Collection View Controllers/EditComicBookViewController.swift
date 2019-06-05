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
        
    let photoSection = 1
    let photoRow = 0
    
    var transactionInfo: CKTransaction?

    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial state
        transactionInfo = CKTransaction(fieldName: "", inputValue: "", outputValue: "", transactionChange: .nochange)
        updateUI()
        
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
            transactionInfo = CKTransaction(fieldName: listPickerKind, inputValue: selectedItem, outputValue: "", transactionChange: .nochange)
        }
        
        func configureAddPicker(kind: String, selectedItem: String) {
            let picker = segue.destination as! PickerAddViewController
            listPickerKind = kind
            picker.pickerTitle = listPickerKind
            picker.hintText = currentComicBook!.identifier
            picker.selectedItemName = selectedItem
            
            // save info about this transaction
            transactionInfo = CKTransaction(fieldName: listPickerKind, inputValue: selectedItem, outputValue: "", transactionChange: .nochange)
        }
        
        func configureDatePicker(kind: String, date: Date) {
            let controller = segue.destination as! PickerDateViewController
            listPickerKind = kind
            controller.pickerTitle = listPickerKind
            controller.hintText = currentComicBook!.identifier
            controller.selectedItemDate = date
            
            // save info about this transaction
            let selectedItemName = currentComicBook?.book.dateText(from: date)
            transactionInfo = CKTransaction(fieldName: listPickerKind, inputValue: selectedItemName!, outputValue: "", transactionChange: .nochange)
        }
        
        switch segue.identifier {
        
        // Standard Picker Cases
        
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
            
        // Picker Add Cases
        
        case "EditVariantSignifierSegue":
            let v = currentComicBook!.comic.variant // never nil
            configureAddPicker(kind: "Variant Info", selectedItem: v)
            
        case "EditPurchasePriceSegue":
            let p = currentComicBook!.book.purchasePriceText // never nil
            configureAddPicker(kind: "Purchase Price", selectedItem: p)

        case "EditSalesPriceSegue":
            let p = currentComicBook!.book.sellPriceText // never nil
            configureAddPicker(kind: "Sales Price", selectedItem: p)
            
        // Picker Date Cases
        
        case "EditPurchaseDateSegue":
            let purchaseDate = currentComicBook?.book.purchaseDate ?? Date()
            configureDatePicker(kind: "Purchase Date", date: purchaseDate)
            
        case "EditSalesDateSegue":
            let sellDate = currentComicBook?.book.sellDate ?? Date()
            configureDatePicker(kind: "Sales Date", date: sellDate)
            
        default:
            fatalError("unsupported seque in EditComicBookViewController")
        }
    }
    
    // MARK:- Unwind/Exit Segues
    
    // TODO: Update data if changed
    // TODO: Detect navigtaion breaking change and prevent it from crashing app. If the currentComicBook can't be found because the publisher, series, issue number, or variant info changed, then alert user and pop back to the SeriesTableViewController.
    // TODO: Data validation
    
    /// Updates the CKTransaction object and updates the UI.
    /// Ensures output is unique and trims whitespace.
    ///
    /// - Parameters:
    ///   - newText: Text the user entered
    ///   - label: The UILabel that needs updating
    ///   - transactionChange: Type of change
    func transact(text: String, label: UILabel, transactionChange: TransactionChange) {
        
        guard let originalTransactionInfo = transactionInfo else {
            return
        }
        
        let newText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if originalTransactionInfo.inputValue != newText {
            let newTransactionInfo = CKTransaction(fieldName: originalTransactionInfo.fieldName, inputValue: originalTransactionInfo.inputValue, outputValue: newText, transactionChange: transactionChange)
            label.text = newTransactionInfo.outputValue
            transactionInfo = newTransactionInfo
        }
    }
    
    // Unwind/exit segue from AddItemViewController
    @IBAction func addItemDidEditItem(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerAddViewController
        
        guard let rawText = controller.newItemTextField.text else {
            return
        }
        
        let newText = rawText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if controller.pickerTitle.contains("Variant") {
            
            transact(text: newText, label: variantLabel, transactionChange: .navigationBreakingChange)
            
        } else if controller.pickerTitle.contains("Purchase") {
            
            transact(text: newText.isEmpty ? "none" : newText, label: purchasePriceLabel, transactionChange: .dataPropertyChange)
            
        } else if controller.pickerTitle.contains("Sales") {
            
            transact(text: newText.isEmpty ? "none" : newText, label: sellPriceLabel, transactionChange: .dataPropertyChange)
            
        } else if controller.pickerTitle.contains("Publisher") {
            
            if !newText.isEmpty {
                transact(text: newText, label: publisherLabel, transactionChange: .navigationBreakingChange)
            }
            
        } else if controller.pickerTitle.contains("Series") {
            
            if !newText.isEmpty {
                transact(text: newText, label: seriesLabel, transactionChange: .navigationBreakingChange)
            }
            
        } else if controller.pickerTitle.contains("Condition") {
            
            if !newText.isEmpty {
                transact(text: newText, label: conditionLabel, transactionChange: .dataPropertyChange)
            }
        }
        
        print("addItemDidEditItem", transactionInfo ?? "")
    }
    
    // Unwind/exit segue from list picker to edit comic book view controller.
    @IBAction func listPickerDidPickItem(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! PickerTableViewController
        let _ = comicBookCollection.comicBook(from: currentIdentifier)
        
        let newText = controller.selectedItemName! // never nil
        
        if listPickerKind == "Publisher" {
            
            transact(text: newText, label: publisherLabel, transactionChange: .navigationBreakingChange)
            
        } else if listPickerKind == "Series" {
            
            transact(text: newText, label: seriesLabel, transactionChange: .navigationBreakingChange)
            
        } else if listPickerKind == "Condition" {
            
            transact(text: newText, label: conditionLabel, transactionChange: .dataPropertyChange)
        }
        
        print("listPickerDidPickItem", transactionInfo ?? "")
    }
    
    // Unwind/exit segue from dial picker to edit comic book view controller.
    @IBAction func dialPickerDidPickItem(_ segue: UIStoryboardSegue) {
        
        print("dialPickerDidPickItem", transactionInfo ?? "")

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
    
    // Unwind/exit segue from date picker to edit comic book view controller.
    @IBAction func datePickerDidPickDate(_ segue: UIStoryboardSegue) {
        
        print("datePickerDidPickDate", transactionInfo ?? "")
        
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
    
    // MARK:- Helpers
    
    func updateUI() {
        
        guard let transactionChange = transactionInfo?.transactionChange else {
            return
        }
        
        switch transactionChange {
            
        case .nochange:
            saveButton.isEnabled = false
            navigationItem.setHidesBackButton(false, animated: true)
            
        case .navigationBreakingChange:
            saveButton.isEnabled = true
            navigationItem.setHidesBackButton(true, animated: true)
            
        case .dataPropertyChange:
            saveButton.isEnabled = false
            navigationItem.setHidesBackButton(true, animated: true)
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

