//
//  PickerTableSectionHeadView.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/27/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class PickerTableSectionHeadView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "PickerTableSectionHead"
    
    static var nib: UINib {
        return UINib(nibName: "PickerTableSectionHead", bundle: nil)
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    
    var photoID: Int!
    var hintText: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let hintText = hintText {
            hintLabel.text = hintText
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
