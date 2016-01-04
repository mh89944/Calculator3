//
//  ViewController.swift
//  Calculator3
//
//  Created by TSUBASA on 15/3/13.
//  Copyright (c) 2015年 TSUBASA. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!

    var userIsInMiddleOfTypingANumber: Bool = false

    // 逻辑层 对象
    var brain = CalculatorBrain()
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInMiddleOfTypingANumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        if userIsInMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            //
            displayValue = result
        } else {
            displayValue = 0
        }
        
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInMiddleOfTypingANumber = false
        }
    }
}

