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
    
    var formulaArray = ["Miles to Kilometer","Kilometer to Miles","Feets to meters", "Yards to meters","Meters to feets","Meters to Yards"]
    var fromUnits = ""
    var toUnits = ""
    var conversionString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        formulaPicker.delegate = self
        formulaPicker.dataSource = self
        conversionString = formulaArray[formulaPicker.selectedRow(inComponent: 0)]
        // Do any additional setup after loading the view, typically from a nib.
    }

    func calculateConversion() {
        
        guard let inputValue = Double(userInput.text!) else {
            print("Show alert")
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
        default:
            print("Show alert, for some reason we didn't have a conversion string")
        }
        let formatString = (decimalSegment.selectedSegmentIndex < decimalSegment.numberOfSegments-1 ? "%.\(decimalSegment.selectedSegmentIndex+1)f": "%f")
        let outputString = String(format: formatString, outputValue)
        resultsLabel.text = "\(inputValue) \(fromUnits) = \(outputString)\(toUnits)"
        
    }
    
    @IBAction func decimalSelected(_ sender: Any) {
        calculateConversion()
        
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
        let unitsArray = formulaArray[row].components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitLabel.text = fromUnits
        resultsLabel.text = toUnits
        calculateConversion()
    }
}
