//
//  BasiCalcApp.swift
//  BasiCalc
//
//  Created by Amer Alyusuf on 16/08/2023.
//

import SwiftUI

@main
struct BasiCalcApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(DarkmodeModifier())
        }
    }
}
