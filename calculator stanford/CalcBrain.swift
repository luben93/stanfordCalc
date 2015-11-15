//
//  CalcBrain.swift
//  calculator stanford
//
//  Model
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
        knownOps["c"]=Op.UnaryOperation("c", { (Double) -> Double in
            self.opStack=[Op]()
            return 0
        })
    }

    
    func pushOperand(operand: Double)->Double?{
        opStack.append(Op.Operand(operand))
        return eval()
    }
    
    func doMath(symbol:String) -> Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return eval()
    }
    
    func eval()->Double?{
        return eval(opStack).res
    }
    
    private func eval(var ops: [Op])->(res:Double?,rem:[Op]){
        if !ops.isEmpty{
            let op = ops.removeLast()
            switch op{
            case .Operand(let operand):
                return (operand,ops)
            case .UnaryOperation(_ , let Operation):
                let opsEval=eval(ops)
                if let operandEval=opsEval.res {
                    return (Operation(operandEval),opsEval.rem)
                }
            case .BinaryOperation(_ , let Operation):
                let opsEval=eval(ops)
                if let operandEval=opsEval.res {
                    let opsEval2=eval(opsEval.rem)
                    if let operandEval2=opsEval2.res {
                        return (Operation(operandEval,operandEval2),opsEval2.rem)
                    }
                }
            }
            
        }
        return (nil,ops)
    }
    
}