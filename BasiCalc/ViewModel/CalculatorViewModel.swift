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
    private var canAddFraction: Bool = true
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
            for item in outputText {
                if item.isNumber {
                    inputText.append("\(item)")
                }
            }
            return
        }
        // MARK: - DELETE LAST!
        else if type == .del {
            if !inputText.isEmpty {
                inputText.removeLast()
            }
        }
        // MARK: - HANDLE SPECIAL CHARACTERS AS THE 1ST INPUT
        else if inputText.isEmpty && buttonTitle == "." {
            inputText += "0."
            canAddFraction = false
        } else if inputText.isEmpty && (buttonTitle == "-" || buttonTitle == "(" || !operators.contains("\(buttonTitle)")) {
            inputText.append("\(buttonTitle)")
        } else if !inputText.isEmpty {
            // MARK: - LAST CHAR IS AN OPERATOR
            if operators.contains(inputText.last!) {
                if buttonTitle == "." {
                    inputText.append("0.")
                } else if buttonTitle == "(" || buttonTitle.first!.isNumber || (inputText.last! == "(" && buttonTitle == "-") || buttonTitle == ")" || inputText.last! == ")" {
                    inputText.append(buttonTitle)
                }
            } else {
                if inputText == outputText {
                    if type == .num {
                        inputText = (buttonTitle)
                    } else if type == .dot {
                        inputText = "0."
                    } else {
                        inputText.append(buttonTitle)
                    }
                } else {
                    inputText.append(buttonTitle)
                }
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
        if inputText.count > 2 {
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
            if operators.contains(arr.last!) && arr.last! != ")"{
                arr.removeLast()
            }
            
            if numOpenP != numClosedP {
                hints = "Unclosed Parentheses..."
                outputText = "?"
                return false
            }
            if arr.count > 2 && arr.contains(where: { element in
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
        print(tempArr)
        // MARK: - MULTIPLICATION, DIVISION, POWER, & √. LEFT TO RIGHT
        #warning("SQRT NOT ADDED YET!")
        var idx = 0
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
            } else if tempArr[idx] == "-" {
                let rightVal = tempArr.remove(at: idx+1)
                tempArr.remove(at: idx)
                var leftVal = ""
                // MINUS SIGN CASE "e.g. (-1+2)"
                if idx == 0 {
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
        print(tempArr)
        return(tempArr.first)
    }
}
