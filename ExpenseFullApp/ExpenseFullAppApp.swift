//
//  ExpenseFullAppApp.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 14/12/23.
//

import SwiftUI

@available(iOS 17.0, *)
@main
struct ExpenseFullAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
