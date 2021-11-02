//
//  CloseKeyboard.swift
//  Study
//
//  Created by cmStudent on 2021/10/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
