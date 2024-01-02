//
//  Search.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 18/12/23.
//

import SwiftUI
import Combine

struct Search: View {
    
    // View Properties
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    
                }
            }
            .overlay {
                VStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 42.0, height: 42.0)
                        .padding(.bottom, 12)
                    
                    Text("Search Transactions")
                        .font(.title3)
                        .bold()
                }
                .opacity(filterText.isEmpty ? 1 : 0)
            }
            .onChange(of: searchText, perform: { newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
