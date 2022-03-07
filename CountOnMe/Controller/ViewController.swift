//
//  ViewController.swift
//  CountOnMe
//
//  Created by Dusan Orescanin on 24/02/2022.
//
import UIKit

final class ViewController: UIViewController {

    // MARK: - Property

    let calculator = Calculator()

    // MARK: - IBOutlet

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var resetTextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegateDisplay = self
    }
}

// MARK: - Action Button

extension ViewController {
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        // resetTextButton.setTitle("C", for: .normal)
        guard let numberText = sender.title(for: .normal) else { return }
        calculator.tappedNumberButton(numberText: numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.tappedAdditionButton()
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.tappedSubstractionButton()
    }

    @IBAction func tappedMultiplicateButton(_ sender: UIButton) {
        calculator.tappedMultiplicateButton()
    }

    @IBAction func tappedDivideButton(_ sender: UIButton) {
        calculator.tappedDivideButton()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.operationResult()
    }

    @IBAction func resetButton(_ sender: UIButton) {
        calculator.resetButton()
        resetTextButton.setTitle("AC", for: .normal)
        textView.text = "0"
    }
}

// MARK: - Alert Action

extension ViewController: DisplayDelegate {
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    func presentDisplay(text: String) {
        textView.text = text
    }
}
