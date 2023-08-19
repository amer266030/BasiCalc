//
//  CalculatorButton.swift
//  BasiCalc
//
//  Created by Amer Alyusuf on 16/08/2023.
//

import SwiftUI

struct CapsuleButton: View {
    let title: String
    let action: () -> Void
    let color: Color = Color.btn3.opacity(0.5)
    
    var body: some View {
        Button(action: action) {
            Text(title)
            .font(.system(.title3, design: .rounded))
            .bold()
            .foregroundStyle(Color.text1)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background {
                Capsule()
                    .foregroundStyle(color.shadow(.inner(color: Color.bg1, radius: 1, x: 0, y: 0)))
                    .blur(radius: 1)
                    
            }
            .background {
                Capsule()
                    .foregroundStyle(color.shadow(.inner(color: Color.bg1, radius: 1, x: 0, y: 0)))
                    .blur(radius: 1)
                    .background(.thinMaterial, in: Capsule())
            }
        }
    }
}

struct CalculatorButton: View {
    let title: String
    let img: Image?
    let color: Color
    let font: Font
    let fontColor: Color
    let action: () -> Void
    
    init(title: String = "", img: Image? = nil, color: Color = Color.btn3.opacity(0.5), font: Font = Font.system(.largeTitle, design: .rounded), fontColor: Color = Color.text1, action: @escaping () -> Void) {
        self.title = title
        self.img = img
        self.color = color
        self.font = font
        self.action = action
        self.fontColor = fontColor
    }
    
    var body: some View {
        Button(action: action) {
            Group {
                if let img {
                    img
                        .font(.system(.title2, design: .rounded))
                } else {
                    Text(title)
                }
            }
            .font(font)
            .bold()
            .foregroundStyle(fontColor)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(color.shadow(.inner(color: Color.bg1, radius: 2, x: 0, y: 0)))
                    .blur(radius: 1)
                    
            }
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(color.shadow(.inner(color: Color.bg1, radius: 2, x: 0, y: 0)))
                    .blur(radius: 1)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
            }
            
        }
    }
}
