//
//  CalculatorViewModel.swift
//  BasiCalc
//
//  Created by Amer Alyusuf on 17/08/2023.
//

import Foundation
import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var outputText: String = "0"
    
    private var reset = false
    
    private let operators = ["e", "µ", "sin", "deg", "+", "-", "*", "/"]
    
    func handleButtonPress(buttonTitle: String) {
        if reset == true {
            inputText = outputText
            reset = false
        }
        if buttonTitle == "=" {
            if !inputText.isEmpty {
                if !inputText.last!.isNumber {
                    inputText.removeLast()
                }
            }
            inputText.append("\(buttonTitle)\(outputText)")
            reset = true
        } else if buttonTitle == "AC" {
            inputText = ""
            outputText = "0"
        } else if buttonTitle == "<-" {
            if !inputText.isEmpty {
                inputText.removeLast()
                if outputText.isEmpty {
                    outputText = "0"
                }
            }
        } else if operators.contains(buttonTitle) {
            if !inputText.isEmpty {
                if !operators.contains("\(inputText.last!)") {
                    inputText.append(buttonTitle)
                } else {
                    inputText.removeLast()
                    inputText.append(buttonTitle)
                }
            }
        } else if buttonTitle.first!.isNumber {
            inputText += buttonTitle
        } else if buttonTitle.first! == "." {
            if !inputText.isEmpty {
                if inputText.last! != "." {
                    inputText.append(buttonTitle)
                }
            } else {
                inputText.append(buttonTitle)
            }
        }
        else {
            print("UNKNOWN ERRRO!")
        }
        calculateResult()
    }
    
    func calculateResult() {
        
        print("input is: \(inputText)")
        var arr: [String] = []
        for char in inputText {
            if arr.isEmpty {
                arr.append("\(char)")
            } else if (char.isNumber || char == ".") && (arr.last!.last!.isNumber || arr.last!.last! == ".") {
                var temp = arr.last!
                arr.removeLast()
                temp += "\(char)"
                arr.append(temp)
            } else {
                arr.append("\(char)")
            }
        }
        
        if arr.count > 2 {
            var index = 0
            while index < arr.count - 1 {
                if arr[index] == "*" {
                    if let leftValue = Double(arr[index - 1]), let rightValue = Double(arr[index + 1]) {
                        let result = leftValue * rightValue
                        arr.removeSubrange(index - 1...index + 1)
                        arr.insert(String(result), at: index - 1)
                    }
                } else if arr[index] == "/" {
                    if let leftValue = Double(arr[index - 1]), let rightValue = Double(arr[index + 1]), rightValue != 0 {
                        let result = leftValue / rightValue
                        arr.removeSubrange(index - 1...index + 1)
                        arr.insert(String(result), at: index - 1)
                    }
                } else {
                    index += 1
                }
            }
            
            index = 0
            while index < arr.count - 1 {
                if arr[index] == "+" {
                    if let leftValue = Double(arr[index - 1]), let rightValue = Double(arr[index + 1]) {
                        let result = leftValue + rightValue
                        arr.removeSubrange(index - 1...index + 1)
                        arr.insert(String(result), at: index - 1)
                    }
                } else if arr[index] == "-" {
                    if let leftValue = Double(arr[index - 1]), let rightValue = Double(arr[index + 1]) {
                        let result = leftValue - rightValue
                        arr.removeSubrange(index - 1...index + 1)
                        arr.insert(String(result), at: index - 1)
                    }
                } else {
                    index += 1
                }
            }
            
            if let result = Double(arr[0]) {
//                print("\(result)")
                
                outputText = "\(result.formatted())"
                
            } else {
                print("No result!")
            }
        }

        print(arr)
    }

}
