//
//  StandardPicker.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/22/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

protocol StandardPicker: class {
    var itemList: [String]! { get set }
    var selectedItemName: String! { get set }
    var pickerTitle: String! { get set }
}
