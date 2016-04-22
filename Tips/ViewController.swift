//
//  ViewController.swift
//  Tips
//
//  Created by Gil Birman on 4/19/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

// TODO
// - Make `defaults` an instance variable ?
// - Use formatters for all number displays


class ViewController: UIViewController {

    @IBOutlet weak var customTipCloseButton: UIButton!
    @IBOutlet weak var customTipView: UIView!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var customTipLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        validateTipPercentages()
    }

    override func viewDidAppear(animated: Bool) {
        // we could re-validate tip percentages here but it shouldn't be necessary
        render()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func handleEditingChanged(sender: AnyObject) {
        renderBillAmount()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onTouchUpInsideCustomTipCloseButton(sender: AnyObject) {
        setCustomTipPercent(nil)
        render()
    }
    
    func validateTipPercentages() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(TIP_PERCENTAGES) as? [Double] ?? []
        
        if tipPercentages.count != 3 {
            // initialize the default percentages since this is the first time
            // (or somehow the data was corrupted)
            tipPercentages = DEFAULT_TIP_PERCENTAGES
            defaults.setObject(tipPercentages, forKey: TIP_PERCENTAGES)
            defaults.synchronize()
        }
    }
    
    func renderBillAmount() {
        let customPercent = getCustomTipPercent()
        let showCustomPercent = customPercent != nil

        var tipPercentage:Double
        
        if (showCustomPercent) {
            tipPercentage = customPercent!
        } else {
            let tipPercentages = getTipPercentages()
            tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        }
        
        let billAmount = DecimalFormatter.numberFromString(billField.text!) as? Double ?? 0.0
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let tipString = CurrencyFormatter.stringFromNumber(tip)
        let totalString = CurrencyFormatter.stringFromNumber(total)
        
        tipLabel.text = tipString
        totalLabel.text = totalString
    }
    
    func renderTipPercentages() {
        let customPercent = getCustomTipPercent()
        let showCustomPercent = customPercent != nil
        
        print("customPercent \(customPercent)")

        customTipView.hidden = !showCustomPercent
        tipControl.hidden = showCustomPercent

        if (showCustomPercent) {
            customTipLabel.text = PercentFormatter.stringFromNumber(customPercent!)
        }

        for (index, percent) in getTipPercentages().enumerate() {
            let pct = PercentFormatter.stringFromNumber(percent)
            tipControl.setTitle(pct, forSegmentAtIndex: index)
        }
    }
    
    func render() {
        renderTipPercentages()
        renderBillAmount()
    }
}

