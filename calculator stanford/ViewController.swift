//
//  ViewController.swift
//  calculator stanford
//
//  Created by lucas persson on 2015-11-07.
//  Copyright © 2015 lucas persson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var brain = CalcBrain()
    var userIsInTheMiddleOfTypinhANumber: Bool = false
    var displayValue: Double {
        get{
            let disp:String = display.text!
            let out:Double = Double(disp)!
            return out
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypinhANumber = false
        }
    }
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypinhANumber{
            display.text = display.text!+digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypinhANumber = true
        }
    }
    
    @IBAction func oprate(sender: UIButton) {
        if userIsInTheMiddleOfTypinhANumber{
            enter()
        }
        if let operation = sender.currentTitle{
            brain.doMath(operation)
            if let res = brain.eval(){
                displayValue = res
            
            }else{
                displayValue = 0 
            }
//            if let res = brain.doMath(operation){
//                displayValue = res
//            }else{
//                displayValue = 0
//            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypinhANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }else{
            displayValue = 0
        }
    }
}

