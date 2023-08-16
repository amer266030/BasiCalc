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
            .font(.system(.headline, design: .rounded))
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.ultraThinMaterial, in: Capsule())
        }
    }
}

struct CalculatorButton: View {
    let title: String
    let img: Image?
    let font: Font = .system(.title2, design: .rounded)
    let color: Color = Color.clear
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Group {
                if let img {
                    img
                        
                } else {
                    Text(title)
                }
            }
            .font(font)
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
    }
}
