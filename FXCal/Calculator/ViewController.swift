//
//  ViewController.swift
//  Calculator
//
//  Created by Yu Wei on 10/2/15.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false {
        willSet(newValue) {
            if !newValue {
                userHasTypedAPoint = false
            }
        }
    }
    var userHasTypedAPoint = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            userIsInTheMiddleOfTypingANumber = true
            display.text = digit
        }
    }
    
    @IBAction func appendPoint(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            if !userHasTypedAPoint {
                userHasTypedAPoint = true
                display.text = display.text! + "."
            }
        } else {
            userIsInTheMiddleOfTypingANumber = true
            userHasTypedAPoint = true
            display.text = "0."
        }
        
    }
    
    @IBAction func appendPI(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        display.text = String(M_PI)
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        history.text = history.text! + " " + String(displayValue)
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
            history.text = history.text! + " " + operation
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

