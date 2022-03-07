//
//  Calculator.swift
//  CountOnMe
//
//  Created by Dusan Orescanin on 24/02/2022.
//

import Foundation

final class Calculator {
    weak var delegateDisplay: DisplayDelegate?

    // MARK: - Property

    var textCalculator = "" {
        didSet {
            notificationDisplay(textCalculator: textCalculator)
        }
    }
    private var textCalculatorDoubled: String {
        return textCalculator.split(separator: " ").map { String("\($0)".isNumber ? "\(Double($0)!)" : $0) }.joined(separator: " ")
    }
    var elements: [String] {
        return textCalculator.split(separator: " ").map { "\($0)" }
    }
    // ERROR CHECH COMPUTED VARIABLES
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    }
    var expressionHaveResult: Bool {
        return textCalculator.contains("=")
    }
    var divideByZero: Bool {
        return !textCalculator.contains("/ 0")
    }
}

// MARK: - numbers and operand Function's

extension Calculator {
    /// Send notification to viewController
    func notificationDisplay(textCalculator: String) {
        delegateDisplay?.presentDisplay(text: textCalculator)
    }
    /// Add Numbers
    func tappedNumberButton(numberText: String) {
        if expressionHaveResult {
            textCalculator = ""
        }
        textCalculator.append(numberText)
    }
    /// Add + Operand
    func tappedAdditionButton() {
        if canAddOperator {
            textCalculator.append(" + ")
        } else {
            delegateDisplay?.presentAlert(message: "Un opérateur est déja mis !")
        }
    }
    /// Add - Operand
    func tappedSubstractionButton() {
        if canAddOperator {
            textCalculator.append(" - ")
        } else {
            delegateDisplay?.presentAlert(message: "Un opérateur est déja mis !")
        }
    }
    /// Add x Operand
    func tappedMultiplicateButton() {
        if canAddOperator {
            textCalculator.append(" * ")
        } else {
            delegateDisplay?.presentAlert(message: "Un opérateur est déja mis !")
        }
    }
    /// Add / Operand
    func tappedDivideButton() {
        if canAddOperator {
            textCalculator.append(" / ")
        } else {
            delegateDisplay?.presentAlert(message: "Un opérateur est déja mis !")
        }
    }
    /// Reset the function
    func resetButton() {
        textCalculator = ""
    }
}

// MARK: - Result Function

extension Calculator {
    func operationResult() {
        guard expressionIsCorrect else {
            delegateDisplay?.presentAlert(message: "Entrez une expression correcte !")
            return
        }
        guard expressionHaveEnoughElement else {
            delegateDisplay?.presentAlert(message: "Ajoutez un opérateur et/ou un autre chiffre !")
            return
        }
        guard divideByZero else {
            delegateDisplay?.presentAlert(message: "La division par zéro impossible car tout nombre divisé par 0 a pour résultat 0 !")
            textCalculator = "Error"
            return
        }
        guard let result = NSExpression(format: textCalculatorDoubled).expressionValue(with: nil, context: nil) as? Double else { return }
        textCalculator = ("\(stringFormater(result: result))")
    }

    /// Function to convert String To Double
    private func stringFormater(result: Double) -> String {
        let formater = NumberFormatter()
        formater.minimumFractionDigits = 0
        formater.maximumFractionDigits = 3
        guard let valueFormated = formater.string(from: NSNumber(value: result)) else { return "" }
        return valueFormated
    }
}

// MARK: - Alert Display Protocol

protocol DisplayDelegate: AnyObject {
    func presentDisplay(text: String)
    func presentAlert(message: String)
}
