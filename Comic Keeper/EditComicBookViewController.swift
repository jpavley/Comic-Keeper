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
    
    var comicBookCollection: ComicBookCollection!
    var currentIdentifier: String!
    var image: UIImage?
    var imageHeight: CGFloat = 260
    var listPickerKind = "Publisher"
    
    let photoSection = 1
    let photoRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        let currentComicBook = comicBookCollection.comicBook(from: currentIdentifier)
        
        title = "#\(currentComicBook?.comic.issueNumber ?? "Edit Comicbook")\(currentComicBook?.comic.variant ?? "")"
        
        publisherLabel.text = currentComicBook?.publisherName
        eraLabel.text = currentComicBook?.seriesEra
        seriesLabel.text = currentComicBook?.seriesName
        issueNumberLabel.text = currentComicBook?.comic.issueNumber
        legacyIssueNumberLabel.text = currentComicBook?.comic.legacyIssueNumber
        variantLabel.text = currentComicBook?.comic.variant
        
        conditionLabel.text = currentComicBook?.book.condition
        purchasePriceLabel.text = currentComicBook?.book.purchasePriceText
        purchaseDateLabel.text = currentComicBook?.book.purchaseDateText
        sellPriceLabel.text = currentComicBook?.book.sellPriceText
        sellDateLabel.text = currentComicBook?.book.sellDateText
    }
    
    @objc func addTapped() {
        print("addTapped()")
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
        
        func configurePicker(kind: String, pickerList: [String], selectedItem: String) {
            listPickerKind = kind
            let picker = segue.destination as! StandardPicker
            picker.itemList = pickerList
            picker.pickerTitle = listPickerKind
            picker.selectedItemName = selectedItem
            picker.hintText = currentComicBook!.identifier
        }
        
        switch segue.identifier {
        case "ChoosePublisherSegue":
            let pl = comicBookCollection.publisherNames.sorted()
            let si = currentComicBook?.comic.publisher
            configurePicker(kind: "Publisher", pickerList: pl, selectedItem: si!)
        case "ChooseSeriesSegue":
            let pl = comicBookCollection.seriesNames.sorted()
            let si = currentComicBook?.comic.series
            configurePicker(kind: "Series", pickerList: pl, selectedItem: si!)
        case "ChooseEraSegue":
            let pl = comicBookCollection.eras
            let si = currentComicBook?.seriesEra
            configurePicker(kind: "Era", pickerList: pl, selectedItem: si!)
        case "ChooseIssueNumber":
            let pl = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook?.comic.issueNumber
            configurePicker(kind: "Issue Number", pickerList: pl, selectedItem: si!)
        case "ChooseLegacyIssueNumber":
            let pl = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook?.comic.legacyIssueNumber
            configurePicker(kind: "Legacy Issue Number", pickerList: pl, selectedItem: si!)
        case "EditVariantSignifierSegue":
            let controller = segue.destination as! AddItemViewController
            controller.viewTitle = "Variant Info"
            controller.hintText = currentComicBook!.identifier
            if let v = currentComicBook?.comic.variant {
                controller.currentItem = v
            }
        case "ChooseConditionSegue":
            let pl = comicBookCollection.allPossibleConditions
            let si = currentComicBook?.book.condition
            configurePicker(kind: "Condition", pickerList: pl, selectedItem: si!)
        case "EditPurchasePriceSegue":
            let controller = segue.destination as! AddItemViewController
            controller.viewTitle = "Purchase Price"
            controller.hintText = currentComicBook!.identifier
            if let price = currentComicBook?.book.purchasePriceText {
                controller.currentItem = price
            }
        default:
            assert(true, "unsupported seque in EditComicBookViewController")
        }
    }
    
    // MARK:- Unwind/Exit Segues
    
    // TODO: Update data if changed
    // TODO: Detect navigtaion breaking change and prevent it from crashing app. If the currentComicBook can't be found because the publisher, series, issue number, or variant info changed, then alert user and pop back to the SeriesTableViewController.
    
    // Unwind/exit segue from AddItemViewController
    @IBAction func addItemDidEditItem(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! AddItemViewController
        
        guard let newText = controller.newItemTextField.text else {
            return
        }
        
        if controller.viewTitle.contains("Variant") {
            variantLabel.text = newText
        } else if controller.viewTitle.contains("Purchase") {
            purchasePriceLabel.text = newText
        }
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
            legacyIssueNumberLabel.text = controller.selectedItemName
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

