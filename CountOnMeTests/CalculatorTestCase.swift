//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Dusan Orescanin on 23/02/2022.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {
    var calculator: Calculator!
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

// MARK: - Add numbers

    func testGivenElementsIsEmpty_WhenAdding23_ThenElementsContains23() {
        calculator.tappedNumberButton(numberText: "23")
        XCTAssertEqual(calculator.textCalculator, "23")
    }

// MARK: - Test canAddOperator

    // Test can add an operand
    func testGivenTestCalculatorIsEmpty_whenAdding25_ThenCanAddOperatorIsTrue() {
        calculator.textCalculator = "25"
        XCTAssertTrue(calculator.canAddOperator)
    }
    // Test add + operand when operand was previously added
    func testGivenTestCalculatorHaveMinusOperand_WhenAddingMinusOperator_ThenCanAddOperatorIsFalse() {
        calculator.textCalculator = "-"
        calculator.tappedSubstractionButton()
        XCTAssertFalse(calculator.canAddOperator)
       }

// MARK: - Test expressionHaveResult

    func testGivenWhenTextCalculatorHaveResult_WhenAdding5_ThenTextCalculatorIsEqual5() {
        calculator.textCalculator = "= 6"
        calculator.tappedNumberButton(numberText: "5")
        XCTAssertEqual(calculator.textCalculator, "5")
    }

// MARK: - expressionHaveEnoughElement

    func testGivenTextCalculatorIsEmpty_WhenAddingEqual_ThenExpressionHaveEnoughElementIsFalse() {
        calculator.operationResult()
        XCTAssertFalse(calculator.expressionHaveEnoughElement)
    }

// MARK: - Add operators

    // Test add Plus Operand
    func testGivenTextCalculatorEqualPlus_WhenAddingPlusOperator_ThenTextCalculatorEqualPLus() {
        calculator.tappedAdditionButton()
        calculator.tappedAdditionButton()
        XCTAssertEqual(calculator.textCalculator, " + ")
    }
    // Test add Minus Operand
    func testGivenTextCalculatorEqualMinus_WhenAddingMinusOperator_ThenTextCalculatorEqualMinus() {
        calculator.tappedSubstractionButton()
        calculator.tappedSubstractionButton()
        XCTAssertEqual(calculator.textCalculator, " - ")
    }
    // Test add Multiplicate Operand
    func testGivenTextCalculatorEqualMultiplicate_WhenAddingMultiplicateOperator_ThenTextCalculatorEqualMultiplicate() {
        calculator.tappedMultiplicateButton()
        calculator.tappedMultiplicateButton()
        XCTAssertEqual(calculator.textCalculator, " * ")
    }
    // Test add Divide Operand
    func testGivenTextCalculatorEqualDivide_WhenAddingDivideOperator_ThenTextCalculatorEqualDivide() {
        calculator.tappedDivideButton()
        calculator.tappedDivideButton()
        calculator.operationResult()
        XCTAssertEqual(calculator.textCalculator, " / ")
    }

// MARK: - operationResult

    // test calculate with priority
    func testGivenTextCalculatorIsEmpty_WhenAdding2Plus3Multiplicate4_ThenTextCalculatorIsEqualTo14() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedAdditionButton()
        calculator.tappedNumberButton(numberText: "3")
        calculator.tappedMultiplicateButton()
        calculator.tappedNumberButton(numberText: "4")
        calculator.operationResult()
        XCTAssertEqual(calculator.textCalculator, "= 14")
    }
    // Test Divide by 0
    func testGivenWhenTextCalculatorIsEmpty_WhenAdding10DivideByO_ThenDivideByZeroIsTrue() {
        calculator.tappedNumberButton(numberText: "10")
        calculator.tappedDivideButton()
        calculator.tappedNumberButton(numberText: "0")
        calculator.operationResult()
        XCTAssertTrue(calculator.divideByZero)
    }

// MARK: - Test boutton AC
    
    func testGivenTextCalculatorIs25Plus7_WhenClearTextCalculator_ThenTextCalculatorIsEmpty() {
        calculator.resetButton()
        XCTAssertEqual(calculator.textCalculator, "")
    }

}
