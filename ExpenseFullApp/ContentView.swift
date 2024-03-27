//
//  ContentView.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 14/12/23.
//

import SwiftUI

struct ContentView: View {
    
    // Visibiliry Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = false
    
    // Active Tab
    @State private var activeTab: Tab = .recents
    
    var body: some View {
        TabView(selection: $activeTab) {
            Recents()
                .tag(Tab.recents)
                .tabItem {
                    Tab.recents.tabContent
                }
            
            Search()
                .tag(Tab.search)
                .tabItem {
                    Tab.search.tabContent
                }
            
            Graphs()
                .tag(Tab.charts)
                .tabItem {
                    Tab.charts.tabContent
                }
            
            Settings()
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
