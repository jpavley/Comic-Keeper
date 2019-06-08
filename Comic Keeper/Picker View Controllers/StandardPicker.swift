//
//  StandardPicker.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/22/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

protocol StandardPicker: class {
    var itemList: [String]! { get set }
    var selectedItemName: String! { get set }
    var pickerTitle: String! { get set }
    var hintText: String! { get set }
    var coverImage: UIImage! { get set }
    var noneButtonVisible: Bool! { get set }
    var viewID: ViewIdentifer! { get set }
}
