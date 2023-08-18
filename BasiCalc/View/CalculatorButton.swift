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
    
    var body: some View {
        Button(action: action) {
            Text(title)
            .font(.system(.title3, design: .rounded))
            .foregroundStyle(Color.text)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.ultraThinMaterial, in: Capsule())
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
    
    init(title: String = "", img: Image? = nil, color: Color = Color.clear, font: Font = Font.system(.largeTitle, design: .rounded), fontColor: Color = Color.text, action: @escaping () -> Void) {
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
            .foregroundStyle(fontColor)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
            .background(color, in: RoundedRectangle(cornerRadius: 16))
        }
    }
}
