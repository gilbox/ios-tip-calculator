//
//  common.swift
//  Tips
//
//  Created by Gil Birman on 4/21/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

func getSavedBillAmount()-> String {
    let defaults = NSUserDefaults.standardUserDefaults()
    let now = NSDate().timeIntervalSince1970
    let timestamp = defaults.doubleForKey(TIME_STAMP)

    if timestamp > 0 && (now - timestamp > SAVE_BILL_AMOUNT_TIMEOUT_MINUTES * 60.0) {
        return ""
    }
    
    return defaults.stringForKey(BILL_AMOUNT) ?? ""
}

func setSavedBillAmount(value: String) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(value, forKey: BILL_AMOUNT)
    defaults.setDouble(NSDate().timeIntervalSince1970, forKey: TIME_STAMP)
    defaults.synchronize()
}

func getTipPercentages()-> [Double] {
    let defaults = NSUserDefaults.standardUserDefaults()
    return defaults.arrayForKey(TIP_PERCENTAGES) as! [Double]
}

func setTipPercentages(value: [Double]) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(value, forKey: TIP_PERCENTAGES)
    defaults.synchronize()
}


func getCustomTipPercent()-> Double? {
    let defaults = NSUserDefaults.standardUserDefaults()
    let value = defaults.doubleForKey(CUSTOM_PERCENT)
    return value < 0 ? nil : value
}

func setCustomTipPercent(value: Double?) {
    print("set!!! \(value)")
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // for some reason it won't let me save nil as the value ʕ ಡ ﹏ ಡ ʔ ... so I use negative number instead
    defaults.setObject(value == nil ? -1 : value, forKey: CUSTOM_PERCENT)
    defaults.synchronize()
}

func createFormatter(style: NSNumberFormatterStyle)-> NSNumberFormatter {
    let f = NSNumberFormatter()
    f.numberStyle = style
    return f
}

func normalizePercentage(value: Double)-> Double {
    // we "round" percentages
    return (round(value*100.0))/100.0
}

let SAVE_BILL_AMOUNT_TIMEOUT_MINUTES = 10.0
let TIME_STAMP = "TIME_STAMP"
let BILL_AMOUNT = "BILL_AMOUNT"
let TIP_PERCENTAGES = "TIP_PERCENTAGES"
let CUSTOM_PERCENT = "CUSTOM_PERCENT"
let DEFAULT_TIP_PERCENTAGES = [0.18, 0.2, 0.22]
let PercentFormatter = createFormatter(.PercentStyle)
let CurrencyFormatter = createFormatter(.CurrencyStyle)
let DecimalFormatter = createFormatter(.DecimalStyle)

