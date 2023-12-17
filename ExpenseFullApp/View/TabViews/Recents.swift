//
//  Recents.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 18/12/23.
//

import SwiftUI

struct Recents: View {
    
    // User properties
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
        GeometryReader {
            // For animation Purpose
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
            }
        }
    }
    
    // Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing:5) {
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer(minLength: 0)
            
            NavigationLink {
                
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient)
                    .clipShape(Circle())
                    .contentShape(Circle())
            }
        }
//        .padding(.bottom, 5)
//        .background {
//            VStack(spacing: 0) {
//                Rectangle()
//                    .fill(.ultraThinMaterial)
//
//                Divider()
//            }
//            .padding(.horizontal, -15)
//            .padding(.top, -(safeArea.top + 15))
//        }
    }
    
}

struct Recents_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

