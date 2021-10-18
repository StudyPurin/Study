//
//  StudyApp.swift
//  Study
//
//  Created by cmStudent on 2021/10/04.
//
import SwiftUI

@main
struct StudyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}

struct SimpleTimer_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
