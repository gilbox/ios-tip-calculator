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
    
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var button0: UIButton! // horrible
    @IBOutlet weak var button1: UIButton! // bad
    @IBOutlet weak var button2: UIButton! // good
    @IBOutlet weak var button3: UIButton! // amazing
    
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
        
        renderQuestionLabel()
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
