//
//  Extensions.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 17/01/23.
//

import SwiftUI

extension View {
    
    /// Use this function to force the keybord to close
    ///
    /// To close the keybord on taps out of the keybord frame, add this function using an .onTapGesture(  )
    ///
    ///  > Example:
    ///  ```
    ///   struct ContentView: View {
    ///     @State var text = ""
    ///
    ///     var body: some View {
    ///         VStack {
    ///             TextField("Type here ...", text: $text)
    ///         }
    ///         .onTapGesture {
    ///             self.hideKeyboard()
    ///         }
    ///     }
    ///   }
    ///  ```
    ///
    ///
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
