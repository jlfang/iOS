//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jialue Fang on 10/19/17.
//  Copyright © 2017 Chris Fang. All rights reserved.
//

import Foundation

//replaced by clousure
/**
func changeSign(operand:Double) -> Double {
    return -operand
}
**/
//replaced by clousure
/**
 func mutiply(op1:Double, op2:Double) -> Double {
    return op1*op2
 }
**/

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    //using enum to define a type with associated value
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    
    //variable operations -> dictionary type with Key: String type and value: Operation type
    private var operations:Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({ -$0}),
        "×" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "+" : Operation.binaryOperation({$0 + $1}),
      
        //Normal Clousure Expression Syntax
      //"−" : Operation.binaryOperation({(op1:Double,op2:Dboule)->Double in return op1-op2})
      
        //Inferring Type From Context 
      //"−" : Operation.binaryOperation({op1,op2 in return op1-op2})
        
        //Implicit Returns from Single-Expression Closures
      //"−" : Operation.binaryOperation({op1,op2 in op1-op2})
        
        //Shorthand Argument
        "−" : Operation.binaryOperation({$0 - $1}),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol:String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value

            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }

            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function:function,firstOperand:accumulator!)
                    accumulator = nil
                }
                
            case .equals:
                performPendingBinaryOperation()


            }
        }
    }
    
    //Calculate result after user press "=" button
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    //struct that stores temp value before user press "=" button
    struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
      
    mutating func setOperand(_ operand :Double) {
        accumulator = operand
        
    }
    
    var result:Double? {
        get {
            return accumulator
        }
    }
}
