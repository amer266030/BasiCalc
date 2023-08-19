//
//  HomeView.swift
//  BasiCalc
//
//  Created by Amer Alyusuf on 16/08/2023.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject private var vm = CalculatorViewModel()
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        ZStack {
            Group {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.bg0, Color.bg1], startPoint: .topTrailing, endPoint: .bottomLeading))
                    .blur(radius: 2)
                    .background(.thickMaterial)
            }
            .ignoresSafeArea()

            VStack {
                // MARK: - DarkMode
                HStack {
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "moon" : "sun.max")
                            .font(.largeTitle)
                            .foregroundStyle(Color.btn1)
                    }
                    Spacer()
                }
                Spacer()
                // MARK: - Text input/output
                VStack {
                    Group {
                        VStack(spacing: 8) {
                            TextField("Enter Calculation", text: $vm.inputText)
                                .foregroundStyle(Color.gray)
                                .font(.system(.body, design: .rounded))
                                .textFieldStyle(.plain)
                            HStack {
                                Spacer()
                                Text(vm.hints)
                                    .font(.system(.caption, design: .rounded))
                                    .foregroundStyle(Color.red)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Text(vm.outputText)
                                .font(.system(.largeTitle, design: .rounded))
                        }
                    }
                    .padding()
                    .multilineTextAlignment(.trailing)
                }
                Spacer()
                
                Grid {
                    // MARK: - Capsules
                    GridRow {
                        Group {
                            CapsuleButton(title: "(") { vm.handleButtonPress(buttonTitle: "(", type: .pOpen) }
                            CapsuleButton(title: ")") { vm.handleButtonPress(buttonTitle: ")", type: .pClose) }
                            CapsuleButton(title: "√") { vm.handleButtonPress(buttonTitle: "√", type: .sqrt) }
                            CapsuleButton(title: "^") { vm.handleButtonPress(buttonTitle: "^", type: .power) }
                        }
                        .aspectRatio(2, contentMode: .fit)
                    }
                    // MARK: - Calac Btns
                    GridRow {
                        Group {
                            CalculatorButton(title: "AC", color: Color.btn4, fontColor: Color.text2) { vm.handleButtonPress(buttonTitle: "AC", type: .ac) }
                            CalculatorButton(title: "<-", img: Image(systemName: "delete.backward"), color: Color.btn4, fontColor: Color.text2) {
                                vm.handleButtonPress(buttonTitle: "<-", type: .del)
                            }
                            CalculatorButton(title: "/", color: Color.btn2, fontColor: Color.text2) {
                                vm.handleButtonPress(buttonTitle: "/", type: .divide)
                            }
                            .fontWeight(.bold)
                            CalculatorButton(title: "*", img: Image(systemName: "staroflife.fill"), color: Color.btn2, fontColor: Color.text2) {
                                vm.handleButtonPress(buttonTitle: "*", type: .multiply)
                            }
                            .fontWeight(.bold)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                    GridRow {
                        Group {
                            CalculatorButton(title: "7") { vm.handleButtonPress(buttonTitle: "7") }
                            CalculatorButton(title: "8") { vm.handleButtonPress(buttonTitle: "8") }
                            CalculatorButton(title: "9") { vm.handleButtonPress(buttonTitle: "9") }
                            CalculatorButton(title: "-", img: Image(systemName: "minus"), color: Color.btn2, fontColor: Color.text2) {
                                vm.handleButtonPress(buttonTitle: "-", type: .minus)
                            }
                            .fontWeight(.bold)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                    // MARK: - Grid
                    GridRow {
                        Rectangle()
                            .gridCellColumns(3)
                            .aspectRatio(contentMode: .fill)
                            .foregroundStyle(Color.clear)
                            .overlay {
                                Grid {
                                    GridRow {
                                        Group {
                                            CalculatorButton(title: "4") { vm.handleButtonPress(buttonTitle: "4") }
                                            CalculatorButton(title: "5") { vm.handleButtonPress(buttonTitle: "5") }
                                            CalculatorButton(title: "6") { vm.handleButtonPress(buttonTitle: "6") }
                                        }
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                    
                                    GridRow {
                                        Group {
                                            CalculatorButton(title: "1") { vm.handleButtonPress(buttonTitle: "1") }
                                            CalculatorButton(title: "2") { vm.handleButtonPress(buttonTitle: "2") }
                                            CalculatorButton(title: "3") { vm.handleButtonPress(buttonTitle: "3") }
                                        }
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                    
                                    GridRow {
                                        HStack {
                                            CalculatorButton(title: "0") { vm.handleButtonPress(buttonTitle: "0") }
                                            .gridCellColumns(2)
                                            .foregroundStyle(Color.red)
                                        }
                                        .gridCellColumns(2)
                                        CalculatorButton(title: ".") { vm.handleButtonPress(buttonTitle: ".", type: .dot) }
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                }
                                
                            }
                        
                        Rectangle()
                            .foregroundStyle(Color.clear)
                            .gridCellColumns(1)
                            .overlay {
                                VStack {
                                    CalculatorButton(title: "+", img: Image(systemName: "plus"), color: Color.btn2, fontColor: Color.text2) {
                                        vm.handleButtonPress(buttonTitle: "+", type: .plus)
                                    }
                                    .fontWeight(.bold)
                                    CalculatorButton(title: "=", color: Color.btn1, fontColor: Color.white) {
                                        vm.handleButtonPress(buttonTitle: "=", type: .equals)
                                    }

                                }
                                .padding(.vertical, 8)
                            }
                    }
                }
            }
            .padding(16)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
//            .preferredColorScheme(.dark)
    }
}
