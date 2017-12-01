//
//  ViewController.swift
//  Calculator
//
//  Created by Jialue Fang on 7/30/17.
//  Copyright © 2017 Chris Fang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Label 
    @IBOutlet weak var display: UILabel!
    
    //Determine whether user is in the middle of typing
    var userIsInTheMiddleOfTyping = false
    
    //Button Action for NUMBERS
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        //if user is in the middle of typing, then add number/operator after the previous text
        if userIsInTheMiddleOfTyping {
            let textCurrentInDisplay = display.text!
            display.text = textCurrentInDisplay + digit
        }
        //if this is the first type, then change the text to the input one
        else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    //Computed Property 
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    //load MODEL: CalculatorBrain
    private var brain = CalculatorBrain()
    
    //Button Action for: OPERATORS
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
      
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
    
    
}

