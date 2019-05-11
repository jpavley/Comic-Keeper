//
//  VariantController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/11/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class VariantController: UIViewController {
    
    var comicBookCollection: ComicBookCollection!
    var currentPublisherName: String!
    var currentSeriesName: String!
    var currentIssueNumber: String!
    var currentVariantSignifier: String!


    @IBOutlet weak var coverView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
