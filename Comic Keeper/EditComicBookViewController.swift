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
    
    @IBOutlet weak var purchasePriceLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var salesPriceLabel: UILabel!
    @IBOutlet weak var salesDateLabel: UILabel!
    
    var comicBookCollection: ComicBookCollection!
    var currentPublisherName: String!
    var currentSeriesName: String!
    var currentIssueNumber: String!
    var currentVariantSignifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
