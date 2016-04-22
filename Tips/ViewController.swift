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

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        validateTipPercentages()
    }

    override func viewDidAppear(animated: Bool) {
        // we could re-validate tip percentages here but it shouldn't be necessary
        renderAll()
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
    
    func validateTipPercentages() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(TIP_PERCENTAGES) as? [Double] ?? []
        
        if (tipPercentages.count != 3) {
            // initialize the default percentages since this is the first time
            // (or somehow the data was corrupted)
            tipPercentages = DEFAULT_TIP_PERCENTAGES
            defaults.setObject(tipPercentages, forKey: TIP_PERCENTAGES)
            defaults.synchronize()
        }
    }
    
    func renderBillAmount() {
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipPercentages = getTipPercentages()
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format:"%.2f", total)
    }
    
    func renderTipPercentages() {
        for (index, percent) in getTipPercentages().enumerate() {
            let pct = PercentFormatter.stringFromNumber(percent)
            tipControl.setTitle(pct, forSegmentAtIndex: index)
        }
    }
    
    func renderAll() {
        renderTipPercentages()
        renderBillAmount()
    }
}

