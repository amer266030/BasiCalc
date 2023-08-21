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
    @Published var hints: String = ""
    
    private var reset = false
    private var canAddOperation: Bool = false
    private var numOpenP = 0
    private var numClosedP = 0
    
    private let operators = "√^()+-*/="
    
    private var arr: [String] = []
    
    func handleButtonPress(buttonTitle: String, type: Operators = .num) {
        hints = ""
        // MARK: - RESET!
        if type == .ac {
            inputText = ""
            outputText = "0"
        } else if type == .equals {
            inputText = ""
            reset = true
            for item in outputText {
                if item.isNumber {
                    inputText.append("\(item)")
                }
            }
        }
        // MARK: - DELETE LAST!
        else if type == .del {
            if !inputText.isEmpty {
                inputText.removeLast()
            }
        }
        // MARK: - HANDLE SPECIAL CHARACTERS AS THE 1ST INPUT
        else if reset == true || inputText.isEmpty {
            if type == .dot {
                inputText = "0."
                outputText = "0"
            } else if type == .num {
                inputText = buttonTitle
            } else if type == .minus || type == .pOpen || type == .sqrt || !operators.contains("\(buttonTitle)") {
                inputText.append("\(buttonTitle)")
            } else if reset == true && !inputText.isEmpty {
                inputText.append("\(buttonTitle)")
            }
            if reset == true { reset = false }
        }
        // MARK: - NON EMPTY INPUT
        else if !inputText.isEmpty {
            // MARK: - LAST CHAR IS AN OPERATOR
            if operators.contains(inputText.last!) {
                if type == .dot {
                    inputText.append("0.")
                } else if inputText.last! == "^" && type == .sqrt {
                    inputText.append("(√")
                } else if type == .pOpen || buttonTitle.first!.isNumber || (inputText.last! == "(" && type == .minus) || type == .pClose || type == .sqrt || inputText.last! == ")" {
                    inputText.append(buttonTitle)
                }
            } else {
                inputText.append(buttonTitle)
            }
        }
        calculateResult()
    }

    func calculateResult() {
        if canConvertToArr() {
            outputText = "0"
            
            if arr.contains(where: { element in
                operators.contains(element)
            }) {
                calcParanthesis()
                if let output = doOperations(arr) {
                    if let num = Double(output) {
                        outputText = num.formatted()
                    }
                }
            }
        }
    }
    
    func canConvertToArr() -> Bool {
        if inputText.count > 1 {
            arr = []
            var idx = 0
            var temp = ""
            numOpenP = 0
            numClosedP = 0
            
            // MARK: - LOOP THROUGH ALL
            while idx < inputText.count {
                if inputText[idx].isNumber || inputText[idx] == "." {
                    temp += "\(inputText[idx])"
                    if idx == inputText.count-1 {
                        arr.append(temp)
                    }
                    idx += 1
                    
                    if temp.numberOfOccurrencesOf(string: ".") > 1 {
                        hints = "multiple '.' in number!"
                        outputText = "ERROR!"
                        return false
                    }
                } else {
                    if !temp.isEmpty { arr.append(temp) }
                    if inputText[idx] == "(" { numOpenP += 1 }
                    else if inputText[idx] == ")" {
                        if numOpenP > numClosedP {
                            numClosedP += 1
                        } else {
                            hints = "No Open Paranthese to Close!"
                            outputText = "ERROR!"
                            return false
                        }
                    }
                    
                    arr.append("\(inputText[idx])")
                    temp = ""
                    idx += 1
                }
            }
            
            // MARK: - CAN'T HAVE AN OPERATOR AT THE END FOR CALCULATION
            while operators.contains(arr.last!) && arr.last! != ")" && arr.count > 1 {
                arr.removeLast()
            }
            if arr.last! == "0." || arr.last == "." {
                arr.removeLast()
                arr.append("0")
            }
            
            if numOpenP != numClosedP {
                hints = "Unclosed Parentheses..."
                outputText = "?"
                return false
            }
            if arr.count > 1 && arr.contains(where: { element in
                operators.contains(element)
            }) {
                return true
            }
        }
        return false
    }
    
    func calcParanthesis() {
        while numClosedP > 0 {
            if let idx = arr.firstIndex(of: ")") {
                numClosedP -= 1
                var i = idx
                var tempArr: [String] = []
                
                if i < arr.count-1 {
                    if arr[i+1].first!.isNumber {
                        arr.insert("*", at: i+1)
                    }
                }
                
                arr.remove(at: i)
                
                while true {
                    i -= 1
                    let temp = arr.remove(at: i)
                    if temp != "(" {
                        tempArr.insert(temp, at: 0)
                    } else {
                        break
                    }
                }
                if let num = doOperations(tempArr) {
                    if i != 0 {
                        if arr[i-1].first!.isNumber {
                            arr.insert("*", at: i)
                            arr.insert(num, at: i+1)
                        } else {
                            arr.insert(num, at: i)
                        }
                    } else {
                        arr.insert(num, at: i)
                    }
                }
            }
        }
    }
    
    func doOperations(_ passedArr: [String]) -> String? {
        var tempArr = passedArr
        // MARK: - POWER, & √. LEFT TO RIGHT
        var idx = 0
        while idx < tempArr.count {
            if tempArr[idx] == "^" {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                let leftVal = tempArr.remove(at: idx-1)
                let result = Double(pow(Double(leftVal)!, Double(rightVal)!))
                tempArr.insert("\(result)", at: idx-1)
            } else if tempArr[idx] == "√" {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                let result = sqrt(Double(rightVal)!)
                
                if idx == 0 {
                    tempArr.insert("\(result)", at: idx)
                } else if tempArr[idx-1].first!.isNumber {
                    tempArr.insert("*", at: idx)
                    tempArr.insert("\(result)", at: idx+1)
                    
                } else {
                    tempArr.insert("\(result)", at: idx)
                }
            } else {
                idx += 1
            }
        }
        // MARK: - MULTIPLICATION, DIVISION
        idx = 0
        while idx < tempArr.count {
            if tempArr[idx] == "*" {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                let leftVal = tempArr.remove(at: idx-1)
                let result = Double(leftVal)! * Double(rightVal)!
                tempArr.insert("\(result)", at: idx-1)
            } else if tempArr[idx] == "/" {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                let leftVal = tempArr.remove(at: idx-1)
                let result = Double(leftVal)! / Double(rightVal)!
                tempArr.insert("\(result)", at: idx-1)
            } else if tempArr[idx] == "^" {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                let leftVal = tempArr.remove(at: idx-1)
                let result = Int(pow(Double(leftVal)!, Double(rightVal)!))
                tempArr.insert("\(result)", at: idx-1)
            } else {
                idx += 1
            }
        }
        // MARK: - ADDITION AND SUBSTRACTION. LEFT TO RIGHT
        idx = 0
        while idx < tempArr.count {
            if tempArr[idx] == "+" {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                let leftVal = tempArr.remove(at: idx-1)
                let result = Double(leftVal)! + Double(rightVal)!
                tempArr.insert("\(result)", at: idx-1)
            } else if tempArr[idx] == "-" && idx < tempArr.count {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                var leftVal = ""
                // MINUS SIGN CASE "e.g. (-1+2)"
                if idx == 0 {
                    leftVal = "0"
                    let result = Double(leftVal)! - Double(rightVal)!
                    tempArr.insert("\(result)", at: idx)
                } else if tempArr[idx-1] == "√" || tempArr[idx-1] == "(" || tempArr[idx-1] == "^" {
                    leftVal = "0"
                    let result = Double(leftVal)! - Double(rightVal)!
                    tempArr.insert("\(result)", at: idx)
                } else {
                    leftVal = tempArr.remove(at: idx-1)
                    let result = Double(leftVal)! - Double(rightVal)!
                    tempArr.insert("\(result)", at: idx-1)
                }
            } else {
                idx += 1
            }
        }
        
        if tempArr.count > 1 {
            tempArr = ["\(tempArr.map { Double($0)! }.reduce(1, *))"]
        }
        
        return(tempArr.first)
    }
}
