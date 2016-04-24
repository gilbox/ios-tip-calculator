//
//  GameViewController.swift
//  Tips
//
//  Created by Gil Birman on 4/21/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let questions = [
        "How was the service?",
        "Was the food dope?",
        "Feng shui?",
        "Reasonable wait times?",
    ]
    
    var currentQuestionIndex = 0
    var score = 0
    var questionLabelCenter: CGPoint = CGPoint()
    var button0Center: CGPoint = CGPoint()
    var button1Center: CGPoint = CGPoint()
    var button2Center: CGPoint = CGPoint()
    var button3Center: CGPoint = CGPoint()
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button0: UIButton! // horrible (bottom-right)
    @IBOutlet weak var button1: UIButton! // bad (bottom-left)
    @IBOutlet weak var button2: UIButton! // good (top-right)
    @IBOutlet weak var button3: UIButton! // amazing (top-left)
    
    @IBOutlet var gameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        questionLabelCenter = questionLabel.center
        button0Center = button0.center
        button1Center = button1.center
        button2Center = button2.center
        button3Center = button3.center
    }

    override func viewDidAppear(animated: Bool) {
        renderQuestionLabel()
    }

    @IBAction func onTouchUpInsideClose(sender: AnyObject) {
        close()
    }
    
    @IBAction func onTouchInsideButton(sender: UIButton) {
        let questionScore = getScoreFromButton(sender)
        print("index score:\(questionScore)... index:\(currentQuestionIndex)" )
        currentQuestionIndex += 1
        score += questionScore
        
        if currentQuestionIndex >= questions.count {
            gameOver()
            return
        }
        
        UIView.animateWithDuration(0.4, animations: {
            self.questionLabel.center = CGPoint(
                x: self.view.frame.size.width + self.questionLabel.frame.size.width/2,
                y: self.questionLabelCenter.y)
        }, completion: { _ in
            self.renderQuestionLabel()
            self.questionLabel.center = CGPoint(
                x: self.questionLabel.frame.size.width / -2,
                y: self.questionLabelCenter.y)
            UIView.animateWithDuration(0.4, animations: {
                self.questionLabel.center = self.questionLabelCenter
            })
        })
        
        animateButtonBounce(sender)
        if (sender != button0) {
            animateButtonRight(button0, originalCenter: button0Center, duration: 0.2) }
        if (sender != button1) {
            animateButtonLeft(button1, originalCenter: button1Center, duration: 0.25) }
        if (sender != button2) {
            animateButtonRight(button2, originalCenter: button2Center, duration: 0.3) }
        if (sender != button3) {
            animateButtonLeft(button3, originalCenter: button3Center, duration: 0.35) }
    }
    
    func animateButtonBounce(button: UIButton) {
        let originalCenter = button.center
        UIView.animateWithDuration(0.1, animations: {
            button.center = CGPoint(x: originalCenter.x, y: originalCenter.y - 30)
        }, completion: { _ in
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping:0.2, initialSpringVelocity:0.5, options: .CurveLinear, animations: {
                button.center = originalCenter
            }, completion: nil)
        })
    }
    
    func animateButtonLeft(button: UIButton, originalCenter: CGPoint, duration: Double) {
        UIView.animateWithDuration(duration, animations: {
            button.center = CGPoint(
                x: button.frame.size.width / -2,
                y: originalCenter.y)
        }, completion: { _ in
            button.center = originalCenter
            button.alpha = 0
            button.transform = CGAffineTransformMakeScale(0.1, 0.1)
            UIView.animateWithDuration(duration, animations: {
                button.alpha = 1
                button.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        })
    }
    
    func animateButtonRight(button: UIButton, originalCenter: CGPoint, duration: Double) {
        UIView.animateWithDuration(duration, animations: {
            button.center = CGPoint(
                x: self.view.frame.size.width + button.frame.size.width / 2,
                y: originalCenter.y)
        }, completion: { _ in
            button.center = originalCenter
            button.alpha = 0
            button.transform = CGAffineTransformMakeScale(0.1, 0.1)
            UIView.animateWithDuration(duration, animations: {
                button.alpha = 1
                button.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        })
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func gameOver() {
        print("game over, score: \(score)")
        let tipPercentages = getTipPercentages()
        let weight = Double(score) / Double(questions.count * 4)
        let delta = tipPercentages[tipPercentages.count-1] - tipPercentages[0]
        let scorePercent = tipPercentages[0] + (delta * weight)
        
        setCustomTipPercent(normalizePercentage(scorePercent))
        close()
    }
    
    func getScoreFromButton(button: UIButton)-> Int! {
        switch button {
        case button0: return 1
        case button1: return 2
        case button2: return 3
        case button3: return 4
        default: return nil
        }
    }
    
    func renderQuestionLabel() {
        questionLabel.text = questions[currentQuestionIndex]
    }
}
