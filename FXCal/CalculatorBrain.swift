//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Yu Wei on 10/2/15.
//
//

import Foundation

class CalculatorBrain {
    enum Op: CustomStringConvertible {
        case operand(Double)
        case unaryOperation(String, (Double) -> Double)
        case binaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .operand(let operand):
                    return "\(operand)"
                case .unaryOperation(let symbol, _):
                    return symbol
                case .binaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }

    
    fileprivate var opStack = [Op]()
    
    fileprivate var knownOps = [String:Op]()
    
    init() {
        knownOps["×"] = Op.binaryOperation("×", *)
        knownOps["÷"] = Op.binaryOperation("÷", { $1 / $0})
        knownOps["+"] = Op.binaryOperation("+", +)
        knownOps["-"] = Op.binaryOperation("-", { $1 - $0})
        knownOps["√"] = Op.unaryOperation("√", sqrt)
        knownOps["sin"] = Op.unaryOperation("sin", sin)
        knownOps["cos"] = Op.unaryOperation("cos", cos)
    }
    
    var program: Any {
        get {
            return opStack.map { $0.description }
        }
        set {
            if let opSymbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand = NumberFormatter().number(from: opSymbol)?.doubleValue {
                        newOpStack.append(.operand(operand))
                    }
                }
            }
        }
    }
    
    func evaluate(_ ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .operand(let operand):
                return (operand, remainingOps)
            case .unaryOperation(_, let operation):
                let operandEvalution = evaluate(remainingOps)
                if let operand = operandEvalution.result {
                    return (operation(operand), operandEvalution.remainingOps)
                }
            case .binaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder)")
        return result
    }
    
    func pushOperand(_ operand: Double) -> Double? {
        opStack.append(Op.operand(operand))
        return evaluate()
    }
    
    func performOperation(_ symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}
