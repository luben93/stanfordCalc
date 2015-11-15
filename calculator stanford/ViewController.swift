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
    
    var userIsInTheMiddleOfTypinhANumber: Bool = false
    var operandStack = Array<Double>()
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
        //print("digit=\(digit)")
        if userIsInTheMiddleOfTypinhANumber{
            display.text = display.text!+digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypinhANumber = true
        }
    }
    
    @IBAction func oprate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypinhANumber{
            enter()
        }
        print(operandStack.last)
        switch operation{
            case "x": doMath {$0 * $1}
            case "/": doMath {$0 / $1}
            case "+": doMath {$0 + $1}
            case "-": doMath {$0 - $1}
            case "√": doMath1 {sqrt($0)}
            default: break
        }
    }
    
    func doMath(operation: (Double, Double) -> Double){
        if(operandStack.count >= 2){
            let first:Double = operandStack.removeLast()
            let second:Double = operandStack.removeLast()
            let res:Double = operation(first,second)
            displayValue = res
            enter()
        }
    }
    
    func doMath1(operation: (Double) -> Double){
        if(operandStack.count >= 1){
            let first:Double = operandStack.removeLast()
            let res:Double = operation(first)
            displayValue = res
            enter()
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypinhANumber = false
        let val:Double = displayValue
        operandStack.append(val)
        print(operandStack)
        
    }
}

