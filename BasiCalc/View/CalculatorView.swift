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
                Image.bgImage
                    .resizable()
                    .blur(radius: 20)
                
                Rectangle()
                    .fill(LinearGradient(colors: [Color.bg2, Color.bg1, Color.bg0], startPoint: .bottomLeading, endPoint: .topTrailing))
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
                            .foregroundStyle(Color.cobalt)
                    }
                    Spacer()
                }
                Spacer()
                // MARK: - Text input/output
                VStack {
                    Group {
                        TextField("Enter Calculation", text: $vm.inputText)
                            .foregroundStyle(Color.gray)
                            .font(.system(.body, design: .rounded))
                            .textFieldStyle(.plain)
                        
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
                            CapsuleButton(title: "e") { vm.handleButtonPress(buttonTitle: "e") }
                            CapsuleButton(title: "µ") { vm.handleButtonPress(buttonTitle: "µ") }
                            CapsuleButton(title: "sin") { vm.handleButtonPress(buttonTitle: "sin") }
                            CapsuleButton(title: "deg") { vm.handleButtonPress(buttonTitle: "deg") }
                        }
                        .aspectRatio(2, contentMode: .fit)
                    }
                    // MARK: - Calac Btns
                    GridRow {
                        Group {
                            CalculatorButton(title: "AC", fontColor: Color.alternateText) { vm.handleButtonPress(buttonTitle: "AC") }
                            CalculatorButton(title: "<-", img: Image(systemName: "delete.backward"), fontColor: Color.alternateText) {
                                vm.handleButtonPress(buttonTitle: "<-")
                            }
                            CalculatorButton(title: "/", color: Color.cobalty, fontColor: Color.chill) {
                                vm.handleButtonPress(buttonTitle: "/")
                            }
                            .fontWeight(.bold)
                            CalculatorButton(title: "*", img: Image(systemName: "staroflife.fill"), color: Color.cobalty, fontColor: Color.chill) {
                                vm.handleButtonPress(buttonTitle: "*")
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
                            CalculatorButton(title: "-", img: Image(systemName: "minus"), color: Color.cobalty, fontColor: Color.chill) {
                                vm.handleButtonPress(buttonTitle: "-")
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
                                        CalculatorButton(title: ".") { vm.handleButtonPress(buttonTitle: ".") }
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                }
                                
                            }
                        
                        Rectangle()
                            .foregroundStyle(Color.clear)
                            .gridCellColumns(1)
                            .overlay {
                                VStack {
                                    CalculatorButton(title: "+", img: Image(systemName: "plus"), color: Color.cobalty, fontColor: Color.chill) {
                                        vm.handleButtonPress(buttonTitle: "+")
                                    }
                                    .fontWeight(.bold)
                                    CalculatorButton(title: "=", color: Color.chilly, fontColor: Color.white) {
                                        vm.handleButtonPress(buttonTitle: "=")
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
