//
//  PickerHeaderViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/28/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class PickerHeaderViewController: UIViewController {
    
    @IBOutlet weak var coverImageVIew: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    
    var hintText: String!
    var photoID: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintLabel.text = hintText
    }
}
