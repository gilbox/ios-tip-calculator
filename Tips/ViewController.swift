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
// - Best way of sharing one formatter throughout the app?
// - Use formatters for all number displays

let TIP_PERCENTAGES = "TIP_PERCENTAGES"
let formatter = NSNumberFormatter()

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formatter.numberStyle = .PercentStyle
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(TIP_PERCENTAGES) as? [Double] ?? []
        
        if (tipPercentages.count != 3) {
            // initialize the default percentages since this is the first time
            tipPercentages = [0.18, 0.2, 0.22]
            defaults.setObject(tipPercentages, forKey: TIP_PERCENTAGES)
            defaults.synchronize()
        }
        
    }

    override func viewDidAppear(animated: Bool) {
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
    
    func renderBillAmount() {
        let billAmount = NSString(string: billField.text!).doubleValue
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipPercentages = defaults.arrayForKey(TIP_PERCENTAGES) as! [Double]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format:"%.2f", total)
    }
    
    func renderTipPercentages() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipPercentages = defaults.arrayForKey(TIP_PERCENTAGES) as! [Double]
        
        for (index, percent) in tipPercentages.enumerate() {
            let pct = formatter.stringFromNumber(percent)
            tipControl.setTitle(pct, forSegmentAtIndex: index)
        }
    }
    
    func renderAll() {
        renderTipPercentages()
        renderBillAmount()
    }
}

