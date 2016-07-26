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
        
        let savedBill = getSavedBillAmount()
        billField.text = savedBill
    }

    override func viewDidAppear(animated: Bool) {
        // we could re-validate tip percentages here but it shouldn't be necessary
        billField.becomeFirstResponder()
        render()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        setSavedBillAmount(billField.text ?? "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func handleTipControlChanged(sender: AnyObject) {
        if (tipControl.selectedSegmentIndex == 3) {
            performSegueWithIdentifier("showGame", sender: nil)
            return
        }
        setCustomTipPercent(nil)
        render()
    }
    
    @IBAction func handleEditingChanged(sender: AnyObject) {
        setSavedBillAmount(billField.text ?? "")
        renderBillAmount()
    }

    func getBillAmount()->Double {
        return DecimalFormatter.numberFromString(billField.text!) as? Double ?? 0.0
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
            if (tipControl.selectedSegmentIndex < 3) {
                tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
            } else {
                tipPercentage = 0
            }
        }
        
        let billAmount = getBillAmount()
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
        
        if (showCustomPercent) {
            let pct = PercentFormatter.stringFromNumber(customPercent!)
            tipControl.setTitle(pct, forSegmentAtIndex: 3)
        } else {
            tipControl.setTitle("¯\\_(ツ)_/¯", forSegmentAtIndex: 3)
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

