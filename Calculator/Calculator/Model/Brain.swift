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
    
    private var accumulator = 0.0
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
    
    var result: Double {
        get {
            return self.accumulator
        }
    }
    
    func setOperand(operand: Double) {
        self.accumulator = operand
    }
    
    func performOperation(symblo: String) {
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
