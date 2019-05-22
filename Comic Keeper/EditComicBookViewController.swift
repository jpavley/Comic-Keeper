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
        
        var pickerList = [String]()
        let currentComicBook = comicBookCollection.comicBook(from: currentIdentifier)
        
        func configurePickerTable(selectedItem: String) {
            let controller = segue.destination as! PickerTableViewController
            controller.itemList = pickerList
            controller.pickerTitle = listPickerKind
            controller.selectedItemName = selectedItem
        }
        
        func configureIssuePickerDial(selectedItem: String) {
            let controller = segue.destination as! ChooseItemViewController
            controller.itemList = pickerList
            controller.pickerTitle = listPickerKind
            controller.selectedItemName = selectedItem
        }
        
        switch segue.identifier {
        case "ChoosePublisherSegue":
            listPickerKind = "Publisher"
            pickerList = comicBookCollection.publisherNames
            let si = currentComicBook?.comic.publisher
            configurePickerTable(selectedItem: si!)
        case "ChooseSeriesSegue":
            listPickerKind = "Series"
            pickerList = comicBookCollection.seriesNames
            let si = currentComicBook?.comic.series
            configurePickerTable(selectedItem: si!)
        case "ChooseEraSegue":
            listPickerKind = "Era"
            pickerList = comicBookCollection.eras
            let si = currentComicBook?.seriesEra
            configureIssuePickerDial(selectedItem: si!)
        case "ChooseIssueNumber":
            listPickerKind = "Issue Number"
            pickerList = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook?.comic.issueNumber
            configureIssuePickerDial(selectedItem: si!)
        case "ChooseLegacyIssueNumber":
            listPickerKind = "Legacy Issue Number"
            pickerList = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook?.comic.legacyIssueNumber
            configureIssuePickerDial(selectedItem: si!)
       default:
            assert(true, "unsupported seque in EditComicBookViewController")
        }
    }
    
    
    /// Unwind/exit segue from list picker to edit comic book view controller.
    @IBAction func listPickerDidPickItem(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerTableViewController
        
        let _ = comicBookCollection.comicBook(from: currentIdentifier)
        
        if listPickerKind == "Publisher" {
            publisherLabel.text = controller.selectedItemName
            
            // TODO: Update data model
            // currentComicBook?.comic.publisher = controller.selectedItemName
        } else if listPickerKind == "Series" {
            seriesLabel.text = controller.selectedItemName
            
            // TODO: Update data model
            // currentComicBook?.comic.series = controller.selectedItemName
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

