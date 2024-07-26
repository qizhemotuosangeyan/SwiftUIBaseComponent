//
//  SwiftUIBaseComponmentsApp.swift
//  SwiftUIBaseComponments
//
//  Created by 千千 on 7/26/24.
//

import SwiftUI

@main
struct SwiftUIBaseComponmentsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
