//
//  HomeView.swift
//  BasiCalc
//
//  Created by Amer Alyusuf on 16/08/2023.
//

import SwiftUI

struct CalculatorView: View {
    
    @State private var textInput: String = ""
    @State private var textOutput: String = ""
    
    var body: some View {
        ZStack {
            
            Group {
                Image.bgImage
                    .resizable()
                
                LinearGradient(colors: [Color.bg0, Color.bg0.opacity(0.9), Color.bg2.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .ignoresSafeArea()

            VStack {
                // MARK: - Text input/output
                Spacer()
                VStack {
                    Group {
                        HStack {
                            Spacer()
                            Text("6000/2+3227*2")
                                .foregroundStyle(Color.gray)
                                .font(.system(.body, design: .rounded))
                        }
                        
                        TextField("0", text: $textOutput)
                            .font(.system(.largeTitle, design: .rounded))
                            .textFieldStyle(.plain)
                    }
                    .padding()
                    .multilineTextAlignment(.trailing)
                }
                Spacer()
                
                Grid {
                    // MARK: - Capsules
                    GridRow {
                        Group {
                            CapsuleButton(title: "e") {
                                
                            }
                            CapsuleButton(title: "µ") {
                                
                            }
                            CapsuleButton(title: "sin") {
                                
                            }
                            CapsuleButton(title: "deg") {
                                
                            }
                        }
                        .aspectRatio(2, contentMode: .fit)
                    }
                    // MARK: - Calac Btns
                    GridRow {
                        Group {
                            CalculatorButton(title: "Ac", img: nil) {
                                
                            }
                            CalculatorButton(title: "", img: Image(systemName: "delete.backward")) {
                                
                            }
                            CalculatorButton(title: "/", img: nil) {
                                
                            }
                            CalculatorButton(title: "*", img: nil) {
                                
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                    GridRow {
                        Group {
                            CalculatorButton(title: "7", img: nil) {
                                
                            }
                            CalculatorButton(title: "8", img: nil) {
                                
                            }
                            CalculatorButton(title: "9", img: nil) {
                                
                            }
                            CalculatorButton(title: "-", img: nil) {
                                
                            }
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
                                            CalculatorButton(title: "4", img: nil) {
                                                
                                            }
                                            CalculatorButton(title: "5", img: nil) {
                                                
                                            }
                                            CalculatorButton(title: "6", img: nil) {
                                                
                                            }
                                        }
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                    
                                    GridRow {
                                        Group {
                                            CalculatorButton(title: "1", img: nil) {
                                                
                                            }
                                            CalculatorButton(title: "2", img: nil) {
                                                
                                            }
                                            CalculatorButton(title: "3", img: nil) {
                                                
                                            }
                                        }
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                    
                                    GridRow {
                                        HStack {
                                            CalculatorButton(title: "0", img: nil) {
                                                
                                            }
                                            .gridCellColumns(2)
                                            .foregroundStyle(Color.red)
                                        }
                                        .gridCellColumns(2)
                                        CalculatorButton(title: ".", img: nil) {
                                            
                                        }
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                }
                                
                            }
                        
                        Rectangle()
                            .foregroundStyle(Color.clear)
                            .gridCellColumns(1)
                            .overlay {
                                VStack {
                                    CalculatorButton(title: "+", img: nil) {
                                        
                                    }
                                    .foregroundStyle(Color.blue)
                                    CalculatorButton(title: "=", img: nil) {
                                        
                                    }
                                    .foregroundStyle(Color.blue)
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
            .preferredColorScheme(.dark)
    }
}
