//
//  EditComicBookViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/12/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit
import CoreData

class EditComicBookViewController: UITableViewController {
    
    // MARK:- Outlets
    
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
    
    // MARK:- Properties
    
    var comicBookCollection: ComicBookCollection!
    var currentIdentifier: String!
    var image: UIImage?
    var imageHeight: CGFloat = 260
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK:- State/Data Management
    
    /// Tracks the current transaction.
    var transactionInfo: CKTransaction?
    
    /// Once the navigation is broken, its broken forever
    var navigationBroken: Bool!
    
    // MARK:- Constants
    
    let photoSection = 1
    let photoRow = 0
    
    // MARK:- Actions
    
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    // MARK:- View Controller
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial state
        transactionInfo = CKTransaction(fieldName: "", inputValue: "", outputValue: "", transactionChange: .nochange)
        navigationBroken = false
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
    
    // MARK:- Table View Implementation
    
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
            let picker = segue.destination as! StandardPicker
            picker.itemList = pickerList
            picker.pickerTitle = kind
            picker.selectedItemName = selectedItem
            picker.hintText = currentComicBook!.identifier
            picker.noneButtonVisible = noneButtonVisible
            
            // save info about this transaction
            transactionInfo = CKTransaction(fieldName: kind, inputValue: selectedItem, outputValue: "", transactionChange: .nochange)
        }
        
        func configureAddPicker(kind: String, selectedItem: String) {
            let picker = segue.destination as! PickerAddViewController
            picker.pickerTitle = kind
            picker.hintText = currentComicBook!.identifier
            picker.selectedItemName = selectedItem
            
            // save info about this transaction
            transactionInfo = CKTransaction(fieldName: kind, inputValue: selectedItem, outputValue: "", transactionChange: .nochange)
        }
        
        func configureDatePicker(kind: String, date: Date) {
            let controller = segue.destination as! PickerDateViewController
            controller.pickerTitle = kind
            controller.hintText = currentComicBook!.identifier
            controller.selectedItemDate = date
            
            // save info about this transaction
            let selectedItemName = currentComicBook?.book.dateText(from: date)
            transactionInfo = CKTransaction(fieldName: kind, inputValue: selectedItemName!, outputValue: "", transactionChange: .nochange)
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
            configureStandardPicker(kind: "Legacy Number", pickerList: pl, selectedItem: si!, noneButtonVisible: true)
            
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
    func transact(fieldName: String, text: String, label: UILabel, transactionChange: TransactionChange) {
        
        guard let originalTransactionInfo = transactionInfo else {
            return
        }
        
        // Once the navigation is broken it is forever broken
        if originalTransactionInfo.transactionChange == .navigationBreakingChange {
            navigationBroken = true
        }
        
        let newText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let newTransactionInfo: CKTransaction
        if originalTransactionInfo.inputValue != newText {
            
            // Has the navigation been broken before?
            let tc: TransactionChange = navigationBroken ? .navigationBreakingChange : transactionChange
            
            newTransactionInfo = CKTransaction(fieldName: originalTransactionInfo.fieldName, inputValue: originalTransactionInfo.inputValue, outputValue: newText, transactionChange: tc)
            
            label.text = newTransactionInfo.outputValue
        } else {
            
            // Has the navigation been broken before?
            let tc: TransactionChange = navigationBroken ? .navigationBreakingChange : .nochange
            
            newTransactionInfo = CKTransaction(fieldName: originalTransactionInfo.fieldName, inputValue: originalTransactionInfo.inputValue, outputValue: newText, transactionChange: tc)
        }
        
        transactionInfo = newTransactionInfo
        updateUI()
    }
    
    // Unwind/exit segue from AddItemViewController
    @IBAction func addItemDidEditItem(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerAddViewController
        
        guard
            let rawText = controller.newItemTextField.text,
            let fieldName = controller.pickerTitle else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }
        
        let newText = rawText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch fieldName {
            
        case let name where name.contains("Variant"):
            transact(fieldName: name, text: newText, label: variantLabel, transactionChange: .navigationBreakingChange)
            
        case let name where name.contains("Purchase"):
            transact(fieldName: name, text: newText.isEmpty ? "none" : newText, label: purchasePriceLabel, transactionChange: .dataPropertyChange)
            
        case let name where name.contains("Sales"):
            transact(fieldName: name, text: newText.isEmpty ? "none" : newText, label: sellPriceLabel, transactionChange: .dataPropertyChange)

        case let name where name.contains("Publisher"):
            if !newText.isEmpty {
                transact(fieldName: name, text: newText, label: publisherLabel, transactionChange: .navigationBreakingChange)
            }

        case let name where name.contains("Series"):
            if !newText.isEmpty {
                transact(fieldName: name, text: newText, label: seriesLabel, transactionChange: .navigationBreakingChange)
            }
            
        case let name where name.contains("Condition"):
            if !newText.isEmpty {
                transact(fieldName: name, text: newText, label: conditionLabel, transactionChange: .dataPropertyChange)
            }

        default:
            fatalError("unexpected fieldName: \(fieldName)")
        }
        
        print("addItemDidEditItem", transactionInfo ?? "")
    }
    
    // Unwind/exit segue from list picker to edit comic book view controller.
    @IBAction func listPickerDidPickItem(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! PickerTableViewController
        let _ = comicBookCollection.comicBook(from: currentIdentifier)
        
        guard
            let newText = controller.selectedItemName,
            let fieldName = controller.pickerTitle else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }
        
        if fieldName.contains("Publisher")  {
            
            transact(fieldName: fieldName, text: newText, label: publisherLabel, transactionChange: .navigationBreakingChange)
            
        } else if fieldName.contains("Series") {
            
            transact(fieldName: fieldName, text: newText, label: seriesLabel, transactionChange: .navigationBreakingChange)
            
        } else if fieldName.contains("Condition"){
            
            transact(fieldName: fieldName, text: newText, label: conditionLabel, transactionChange: .dataPropertyChange)
        }
        
        print("listPickerDidPickItem", transactionInfo ?? "")
    }
    
    // Unwind/exit segue from dial picker to edit comic book view controller.
    @IBAction func dialPickerDidPickItem(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! PickerDialViewController
        
        guard
            let newText = controller.selectedItemName,
            let fieldName = controller.pickerTitle else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }
        
        if fieldName.contains("Era") {
            
            transact(fieldName: fieldName, text: newText, label: eraLabel, transactionChange: .navigationBreakingChange)
            
        } else if fieldName.contains("Issue") {
            
            transact(fieldName: fieldName, text: newText, label: issueNumberLabel, transactionChange: .navigationBreakingChange)
            
        } else if fieldName.contains("Legacy") {
            
            transact(fieldName: fieldName, text: newText.isEmpty ? "none" : newText, label: legacyIssueNumberLabel, transactionChange: .dataPropertyChange)
        }
        
        print("dialPickerDidPickItem", transactionInfo ?? "")
    }
    
    // Unwind/exit segue from date picker to edit comic book view controller.
    @IBAction func datePickerDidPickDate(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! PickerDateViewController
        
        guard
            let newText = controller.selectedItemName,
            let fieldName = controller.pickerTitle else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }

        if fieldName.contains("Purchase Date") {
            
            transact(fieldName: fieldName, text: newText.isEmpty ? "none" : newText, label: purchaseDateLabel, transactionChange: .dataPropertyChange)
            
        } else if fieldName.contains("Sales Date") {
            
            transact(fieldName: fieldName, text: newText.isEmpty ? "none" : newText, label: sellDateLabel, transactionChange: .dataPropertyChange)
        }
        
        print("datePickerDidPickDate", transactionInfo ?? "")
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
            navigationItem.setHidesBackButton(false, animated: true)
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
        startPhotoTransaction()
        let imagePicker = createImagePicker(kind: .camera)
        present(imagePicker, animated: true, completion: {
            // TODO: This is called before the photo is choosen!
            self.completePhotoTransaction(newPhotoID: "0")
        })
    }
    
    func choosePhotoFromLibrary() {
        startPhotoTransaction()
        let imagePicker = createImagePicker(kind: .photoLibrary)
        present(imagePicker, animated: true, completion: {
            // TODO: This is called before the photo is choosen!
            self.completePhotoTransaction(newPhotoID: "0")
        })
    }
    
    private func startPhotoTransaction() {
        
        let currentComicBook = comicBookCollection.comicBook(from: currentIdentifier)
        let currentPhotoID = currentComicBook?.book.photoID ?? 0
        
        let newTransaction = CKTransaction(fieldName: "Photo", inputValue: "\(currentPhotoID)", outputValue: "", transactionChange: .nochange)
        
        transactionInfo = newTransaction
    }
    
    private func completePhotoTransaction(newPhotoID: String) {
        let dummyLabel = UILabel()
        self.transact(fieldName: "Photo", text: newPhotoID, label: dummyLabel, transactionChange: .dataPropertyChange)
        print("choosePhotoFromLibrary", self.transactionInfo ?? "")
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

