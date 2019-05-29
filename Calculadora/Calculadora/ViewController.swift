//
//  ViewController.swift
//  Calculadora
//
//  Created by Gunther Ribak on 27/05/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!
    
    var result: Double = 0 {
        didSet {
            resultLabel.text = "\(result)"
        }
    }
    
    var currentEquation: Equation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onDigitSelected(_ sender: UIButton) {
        self.result = 0
        if let digit: String = sender.titleLabel?.text, var sValue = self.valueField.text {
            sValue += digit
            self.valueField.text = sValue
        }
    }
    
    @IBAction func onOperationSelected(_ sender: UIButton) {
        if let operation: String = sender.titleLabel?.text, let sValue = self.valueField.text, let value = Double(sValue)  {
            var signal: Signals
            switch operation {
            case "x²":
                signal = .pow
            case "√":
                signal = .sqrt
            case "*":
                signal = .mult
            case "/":
                signal = .div
            case "+":
                signal = .add
            case "-":
                signal = .sub
            default:
                return
            }
            self.currentEquation = Equation(signal: signal, value1: value)
            if signal == .pow || signal == .sqrt {
                calculateResult()
            }
            self.valueField.text = ""
        }
    }
    
    @IBAction func executeOperation(_ sender: UIButton) {
        if let sValue = self.valueField.text, let value = Double(sValue), self.currentEquation != nil {
            self.currentEquation!.value2 = value
            calculateResult()
        }
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        self.result = 0
        self.currentEquation = nil
        self.valueField.text = ""
    }
    
    func calculateResult() {
        if let equation = self.currentEquation {
            switch (equation.signal) {
            case .pow:
                self.result = pow(equation.value1, 2)
            case .sqrt:
                self.result = sqrt(equation.value1)
            case .mult:
                if let value2 = equation.value2 {
                    self.result = equation.value1 * value2
                }
            case .div:
                if let value2 = equation.value2 {
                    self.result = equation.value1 / value2
                }
            case .add:
                if let value2 = equation.value2 {
                    self.result = equation.value1 + value2
                }
            case .sub:
                if let value2 = equation.value2 {
                    self.result = equation.value1 - value2
                }
            }
        }
        self.currentEquation = nil
        self.valueField.text = ""
    }
}

