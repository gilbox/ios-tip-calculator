//
//  SettingsViewController.swift
//  Tips
//
//  Created by Gil Birman on 4/20/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {

    @IBOutlet weak var percentLabel0: UILabel!
    @IBOutlet weak var percentLabel1: UILabel!
    @IBOutlet weak var percentLabel2: UILabel!
    @IBOutlet weak var percentSlider0: UISlider!
    @IBOutlet weak var percentSlider1: UISlider!
    @IBOutlet weak var percentSlider2: UISlider!
    @IBAction func onTouchUpInsideClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(TIP_PERCENTAGES) as! [Double]
    
        setValueForSlider(tipPercentages[0], slider: percentSlider0)
        setValueForSlider(tipPercentages[1], slider: percentSlider1)
        setValueForSlider(tipPercentages[2], slider: percentSlider2)
    }
    

    @IBAction func onSliderValueChanged(sender: UISlider) {
        let label = getLabelForSlider(sender)
        setValueForLabel(Double(sender.value), label: label)
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(getTipPercentages(), forKey: TIP_PERCENTAGES)
        defaults.synchronize()
    }
    
    func normalizePercentage(value: Double)-> Double {
        // we "round" percentages
        return (round(value*100.0))/100.0
    }
    
    func getTipPercentages()-> Array<Double> {
        return [
            normalizePercentage(Double(percentSlider0.value)),
            normalizePercentage(Double(percentSlider1.value)),
            normalizePercentage(Double(percentSlider2.value)),
        ]
    }
    
    func getLabelForSlider(slider: UISlider)-> UILabel! {
        switch slider {
        case percentSlider0: return percentLabel0
        case percentSlider1: return percentLabel1
        case percentSlider2: return percentLabel2
        default: return nil // TODO: Is forcing an error this way good practice?
        }
    }
    
    func setValueForLabel(value: Double, label: UILabel) {
        label.text = formatter.stringFromNumber(value)
    }
    
    func setValueForSlider(value: Double, slider: UISlider) {
        let label = getLabelForSlider(slider)
        slider.value = Float(value)
        setValueForLabel(value, label: label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
