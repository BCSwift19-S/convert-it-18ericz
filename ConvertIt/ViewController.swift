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
    
    var formulaArray = ["Miles to Kilometer","Kilometer to Miles","Feets to meters", "Yards to meters","Meters to feets","Meters to Yards"]
    var fromUnits = ""
    var toUnits = ""
    var conversionString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        formulaPicker.delegate = self
        formulaPicker.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    func calculateConversion() {
        var outputValue = 0.0
        if let inputValue = Double(userInput.text!){
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
            default:
                print("Show alert, for some reason we didn't have a conversion string")
            }
            resultsLabel.text = "\(inputValue) \(fromUnits) = \(outputValue)\(toUnits)"
        }else{
            print("")
        }
        
    }
    @IBAction func convertButtonPressed(_ sender: UIButton) {
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
        let unitsArray = formulaArray[row].components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitLabel.text = fromUnits
        resultsLabel.text = toUnits
        calculateConversion()
    }
}
