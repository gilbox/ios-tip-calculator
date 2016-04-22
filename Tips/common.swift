//
//  common.swift
//  Tips
//
//  Created by Gil Birman on 4/21/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

func getTipPercentages()-> [Double] {
    let defaults = NSUserDefaults.standardUserDefaults()
    return defaults.arrayForKey(TIP_PERCENTAGES) as! [Double]
}

func setTipPercentages(value: [Double]) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(value, forKey: TIP_PERCENTAGES)
    defaults.synchronize()
}

func createFormatter(style: NSNumberFormatterStyle)-> NSNumberFormatter {
    let f = NSNumberFormatter()
    f.numberStyle = style
    return f
}

let TIP_PERCENTAGES = "TIP_PERCENTAGES"
let DEFAULT_TIP_PERCENTAGES = [0.18, 0.2, 0.22]
let PercentFormatter = createFormatter(.PercentStyle)
let CurrencyFormatter = createFormatter(.CurrencyStyle)
let DecimalFormatter = createFormatter(.DecimalStyle)

