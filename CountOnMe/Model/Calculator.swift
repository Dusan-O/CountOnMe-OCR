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
    // Error check computed variables
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
        //return elements.firstIndex(of: "=") != nil
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
    /// Add Plus Operand
    func tappedAdditionButton() {
        if canAddOperator {
            textCalculator.append(" + ")
        } else {
            delegateDisplay?.presentAlert(message: "Un operateur est déja mis !")
        }
    }
    /// Add Minus Operand
    func tappedSubstractionButton() {
        if canAddOperator {
            textCalculator.append(" - ")
        } else {
            delegateDisplay?.presentAlert(message: "Un operateur est déja mis !")
        }
    }
    /// Add Multiplicate Operand
    func tappedMultiplicateButton() {
        if canAddOperator {
            textCalculator.append(" * ")
        } else {
            delegateDisplay?.presentAlert(message: "Un operateur est déja mis !")
        }
    }
    /// Add Divide Operand
    func tappedDivideButton() {
        if canAddOperator {
            textCalculator.append(" / ")
        } else {
            delegateDisplay?.presentAlert(message: "Un operateur est déja mis !")
        }
    }
    /// Reset function
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
            delegateDisplay?.presentAlert(message: "Ajouter un opérateur et un autre chiffre !")
            return
        }
        guard divideByZero else {
            delegateDisplay?.presentAlert(message: "Division par zéro impossible !")
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
