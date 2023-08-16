//
//  DarkModeModifier.swift
//  BasiCalc
//
//  Created by Amer Alyusuf on 16/08/2023.
//

import SwiftUI

public struct DarkmodeModifier: ViewModifier {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
