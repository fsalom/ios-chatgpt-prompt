//
//  chatgptApp.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import SwiftUI

@main
struct chatgptApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ChatBuilder().build()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
