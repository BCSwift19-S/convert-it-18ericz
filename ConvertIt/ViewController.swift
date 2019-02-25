//
//  ViewController.swift
//  ConvertIt
//
//  Created by 18ericz on 2/24/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var fromUnitLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    @IBOutlet weak var signSegment: UISegmentedControl!
    
    var formulaArray = ["Miles to Kilometer","Kilometer to Miles","Feets to meters", "Yards to meters","Meters to feets","Meters to Yards","Inches to cm", "Cm to Inches", "Fahrenheit to Celsius", "Celsius to Fahrenheit", "Quarts to Liters", "Liters to Quarts"]
    var fromUnits = ""
    var toUnits = ""
    var conversionString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        formulaPicker.delegate = self
        formulaPicker.dataSource = self
        conversionString = formulaArray[formulaPicker.selectedRow(inComponent: 0)]
        userInput.becomeFirstResponder()
        signSegment.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    func calculateConversion() {
        
        guard let inputValue = Double(userInput.text!) else {
            if userInput.text != ""{
                showAlert(title: "Cannot convert value", message: "\"\(userInput.text!)\" is not a valid number")
            }
            return
        }
        var outputValue = 0.0
        switch conversionString {
        case "Miles to Kilometer":
            outputValue = inputValue / 0.62137
        case "Kilometer to Miles":
            outputValue = inputValue * 0.62137
        case "Feets to meters":
            outputValue = inputValue / 3.2808
        case "Yards to meters":
            outputValue = inputValue / 1.0936
        case "Meters to feets":
            outputValue = inputValue * 3.2808
        case "Meters to Yards":
            outputValue = inputValue * 1.0936
        case "Inches to cm":
            outputValue = inputValue / 0.3937
        case "Cm to Inches":
            outputValue = inputValue * 0.3937
        case "Fahrenheit to Celsius":
            outputValue = (inputValue - 32) * (5/9)
        case "Celsius to Fahrenheit":
            outputValue = (inputValue)*(9/5) + 32
        case "Quarts to Liters":
            outputValue = inputValue / 1.05669
        case "Liters to Quarts":
            outputValue = inputValue * 1.05669
        default:
            showAlert(title: "Unexpected Error", message: "Contact developer and share that \"\(conversionString)\" could not be identified.")
        }
        let formatString = (decimalSegment.selectedSegmentIndex < decimalSegment.numberOfSegments-1 ? "%.\(decimalSegment.selectedSegmentIndex+1)f": "%f")
        let outputString = String(format: formatString, outputValue)
        resultsLabel.text = "\(inputValue) \(fromUnits) = \(outputString)\(toUnits)"
        
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func userInputChanged(_ sender: UITextField) {
        resultsLabel.text = ""
        if userInput.text?.first == "-" {
            signSegment.selectedSegmentIndex = 1
        }else{
            signSegment.selectedSegmentIndex = 0
        }
    }
    @IBAction func decimalSelected(_ sender: Any) {
        calculateConversion()
        
    }
    
    @IBAction func signSegmentSelected(_ sender: UISegmentedControl) {
        if signSegment.selectedSegmentIndex == 0{
            userInput.text = userInput.text?.replacingOccurrences(of: "-", with: "")
        }else{
            userInput.text = "-" + userInput.text!
        }
        if userInput.text != "-"{
            calculateConversion()
        }

    }
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        calculateConversion()
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formulaArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formulaArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        conversionString = formulaArray[row]
        
        if conversionString.contains("Celsius"){
            signSegment.isHidden = false
        } else {
            signSegment.isHidden = true
            userInput.text = userInput.text?.replacingOccurrences(of: "-", with: "")
            signSegment.selectedSegmentIndex = 0
        }
        let unitsArray = formulaArray[row].components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitLabel.text = fromUnits
        calculateConversion()
    }
}
