//
//  Brain.swift
//  Calculator
//
//  Created by Jonatas Saraiva on 06/02/17.
//  Copyright © 2017 jonatas saraiva. All rights reserved.
//

import Foundation

struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
}

class Brain {
    typealias PropertyList = AnyObject
    
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    private var pending: PendingBinaryOperationInfo?
    
    private enum Operatin {
        case Constant(Double)
        case Unary((Double) -> Double)
        case Binary((Double, Double) -> Double)
        case Equals
    }
    
    private var operations: Dictionary<String, Operatin> = [
        "π" : Operatin.Constant(M_PI),
        "e" : Operatin.Constant(M_E),
        "√" : Operatin.Unary(sqrt),
        "cos" : Operatin.Unary(cos),
        "×" : Operatin.Binary({ $0 * $1 }),
        "÷" : Operatin.Binary({ $0 / $1 }),
        "+" : Operatin.Binary({ $0 + $1 }),
        "−" : Operatin.Binary({ $0 - $1 }),
        "=" : Operatin.Equals
    ]
    
    private func executePendingBinarayOperation() {
        if pending != nil {
            self.accumulator = self.pending!.binaryFunction(self.pending!.firstOperand, self.accumulator)
            self.pending = nil
        }
    }
    
    private func clear() {
        self.accumulator = 0.0
        self.pending = nil
        self.internalProgram.removeAll()
    }
    
    var result: Double {
        get {
            return self.accumulator
        }
    }
    
    var program: PropertyList {
        get {
            return self.internalProgram as Brain.PropertyList
        }
        
        set {
            self.clear()
            
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        self.setOperand(operand: operand)
                    } else if let operantion = op as? String {
                        self.performOperation(symblo: operantion)
                    }
                }
            }
        }
    }
    
    
    
    func setOperand(operand: Double) {
        self.accumulator = operand
        self.internalProgram.append(operand as AnyObject)
    }
    
    func performOperation(symblo: String) {
        self.internalProgram.append(symblo as AnyObject)
        if let operation = self.operations[symblo] {
            switch operation {
            case .Binary(let function):
                self.executePendingBinarayOperation()
                self.pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: self.accumulator)
            case .Constant(let value):
                self.accumulator = value
            case .Equals:
                self.executePendingBinarayOperation()
            case .Unary(let function):
                self.accumulator = function(self.accumulator)
            }
        }
        
    }
}
