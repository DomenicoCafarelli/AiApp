//
//  Extensions.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 17/01/23.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
