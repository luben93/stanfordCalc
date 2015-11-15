//
//  CalcBrain.swift
//  calculator stanford
//
//  Created by lucas persson on 2015-11-15.
//  Copyright © 2015 lucas persson. All rights reserved.
//

import Foundation

class CalcBrain {
    private enum Op{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double,Double)->Double)
    }

    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init(){
        knownOps["+"]=Op.BinaryOperation("+", +)
        knownOps["-"]=Op.BinaryOperation("-"){$1-$0}
        knownOps["x"]=Op.BinaryOperation("x", *)
        knownOps["/"]=Op.BinaryOperation("/"){$1/$0}
        knownOps["√"]=Op.UnaryOperation("√", sqrt)
    }
    
    func pushOperand(operand: Double){
        opStack.append(Op.Operand(operand))
    }
    
    func doMath(symbol:String){
        if let operation = knownOps[symbol] {
                opStack.append(operation)
        }
    }
    
    func eval()->Double?{
        return eval(opStack)
    }
    
    private func eval(var ops: [Op])->(res:Double?,remainig:[Op]){
        if !ops.isEmpty{
            let op = ops.removeLast()
            
        }
     return (nil,ops)
    }
    
}