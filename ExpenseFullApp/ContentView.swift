//
//  ContentView.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 14/12/23.
//

import SwiftUI

struct ContentView: View {
    
    // Visibiliry Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    // Active Tab
    @State private var activeTab: Tab = .recents

    var body: some View {
        TabView(selection: $activeTab) {
            Text("Recents")
                .tag(Tab.recents)
                .tabItem {
                    Tab.recents.tabContent
                }
            
            Text("Search")
                .tag(Tab.search)
                .tabItem {
                    Tab.search.tabContent
                }
            
            Text("Chart")
                .tag(Tab.charts)
                .tabItem {
                    Tab.charts.tabContent
                }
            
            Text("Settings")
                .tag(Tab.settings)
                .tabItem {
                    Tab.settings.tabContent
                }
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstTime) {
            IntroScreen()
                .interactiveDismissDisabled()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
