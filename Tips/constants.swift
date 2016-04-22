//
//  constants.swift
//  Tips
//
//  Created by Gil Birman on 4/21/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

//import Foundation
import UIKit

func createFormatter(style: NSNumberFormatterStyle)-> NSNumberFormatter {
    let f = NSNumberFormatter()
    f.numberStyle = style
    return f
}

let TIP_PERCENTAGES = "TIP_PERCENTAGES"
let DEFAULT_TIP_PERCENTAGES = [0.18, 0.2, 0.22]
let percentFormatter = createFormatter(.PercentStyle)
