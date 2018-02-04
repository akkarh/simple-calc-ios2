//
//  ViewController.swift
//  SimpleCalc-2
//
//  Created by Harshitha Akkaraju on 2/1/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var prev = 0.0
    var curr = 0.0
    var opSelected = false
    var operation = ""
    var newOp = false
    var decimal = false
    var input = [Double]()
    var history = [String]()
    var expression = ""
    
    @IBOutlet weak var output: UILabel!
    
    @IBAction func showHistory(_ sender: Any) {
        performSegue(withIdentifier: "historyVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HistoryViewController {
            destination.expressions = history
        }
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        // clear the screen when operation is selected
        // or when one operation has been evaluated
        if (opSelected || newOp) {
            output.text = ""
            opSelected = false
            newOp = false
        }
        // update screen output
        output.text = output.text! + String(sender.tag - 1)
    }
    
    // records decimal operation
    @IBAction func decimal(_ sender: UIButton) {
        if (!decimal) {
            output.text = output.text! + String(".")
            decimal = true
        }
    }
    
    // clears the screen and resets starter variables
    @IBAction func clearPressed(_ sender: UIButton) {
        output.text = ""
        clear()
    }
    
    // records operation
    @IBAction func operation(_ sender: UIButton) {
        if !opSelected {
            prev = Double(output.text!)!
            expression += output.text!
            output.text = ""
            opSelected = true
            operation = sender.titleLabel!.text!
            expression = "" + expression + " " + operation + " "
        }
    }
    
    // records the factorial operation
    @IBAction func factPressed(_ sender: UIButton) {
        if !opSelected {
            opSelected = true
            operation = "fact"
            newOp = false
        }
        expression += output.text! + " "
        expression += "fact"
        input.append(Double(output.text!)!)
    }
    
    // evaluates the factorial operation
    func evalFact() -> String {
        if input.count > 1 {
            return String("Error!")
        } else {
            let n = Int(input[0])
            var prod = 1
            for i in 1...n {
                prod *= i
            }
            return "" + String(prod)
        }
    }
    
    // records count and appends the number to input
    @IBAction func countPressed(_ sender: UIButton) {
        if !opSelected {
            opSelected = true
            operation = "count"
            newOp = false
        }
        expression += output.text! + " "
        expression += "count"
        input.append(Double(output.text!)!)
    }
    
    // records avg operation and appends the number to input
    @IBAction func avgPressed(_ sender: UIButton) {
        if !opSelected {
            opSelected = true
            operation = "avg"
            newOp = false
        }
        expression += output.text! + " "
        expression += "avg"
        input.append(Double(output.text!)!)
    }
    
    // computes the average of the elements in input
    func computeAvg() -> String {
        var sum = 0.0
        for i in input {
            sum += i
        }
        return "" + String(sum / Double(input.count))
    }
    
    // displays a decimal / int based on whether or not decimal has been selected
    func displayResult(_ result: String) {
        if result != "" && result != "Error!" {
            if (decimal) {
                output.text = result
                expression += " " + result
            } else {
                let num = Double(result)
                output.text = String(Int(num!))
                expression += " " + String(Int(num!))
            }
        }
        history.append(expression)
    }
    
    // evaluates the expression so far
    @IBAction func equalsPressed(_ sender: UIButton) {
        var result = ""
        if output.text != "" {
            curr = Double(output.text!)!
            expression += output.text! + " = "
            switch operation {
            case "+" :
                result = String((prev + curr))
            case "-" :
                result = String((prev - curr))
            case "x" :
                result = String((prev * curr))
            case "÷" :
                result = String((prev / curr))
            case "%" :
                result = String(prev.truncatingRemainder(dividingBy: curr))
            case "fact" :
                result = evalFact()
            case "count" :
                input.append(Double(output.text!)!)
                result = "" + String(input.count)
            case "avg" :
                input.append(Double(output.text!)!)
                result = computeAvg()
            default :
                output.text = "Error!"
            }
        }
        displayResult(result)
        clear()
    }
    
    // resets the starter variables
    func clear() {
        prev = 0.0
        curr = 0.0
        opSelected = false
        operation = ""
        decimal = false
        input = [Double]()
        newOp = true
        expression = ""
    }
}



