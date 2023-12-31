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
    
    // View
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var showFilterView: Bool = false
    @State private var selectedCategory: Category = .expense
    
    // @ObservedObject var transactionData = TransactionData()
    
    // For animation
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {
            // For animation Purpose
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    // HeaderView(size)
                    
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            // Date Filter
                            Button {
                                showFilterView = true
                            } label: {
                                Text("\(format(date: startDate, format: "dd - MMM yy")) to \(format(date: endDate, format: "dd - MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            }
                            .hSpacing(.leading)
                            
                            // Card View
                            CardView(income: 500000, expense: 250000)
                    
                            // Custom Segemented Control
                            CustomSegmentedControl()
                                .padding(.bottom, 10)
                            
                            // Items
                            ForEach(sampleTransaction.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                                
                                TransactionCardView(transaction: transaction)
                                    .contextMenu {
                                        Button {
                                            removeTransaction(with: transaction.id.uuidString)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .swipeActions(edge: .leading, content: {
                                        Button(role: .destructive) {
                                            withAnimation(.linear(duration: 0.4)) {
                                                removeTransaction(with: transaction.id.uuidString)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    })
                                    .tint(.red)
                            }
                            .onDelete { indexSet in
                                // Handle deletion when user swipes and taps delete
                                let indicesToDelete = indexSet.map { $0 }
                                for index in indicesToDelete {
                                    let transaction = sampleTransaction[index]
                                    removeTransaction(with: transaction.id.uuidString)
                                }
                            }

                        } header: {
                             HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 8 : 0)
                .disabled(showFilterView)
            }
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.spring(), value: showFilterView)
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
        .padding(.bottom, 5)
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
    
    // Segmented Control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0, content: {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedCategory = category
                        }
                    }
            }
        })
        .background(Capsule().fill(.gray.opacity(0.15)))
        .padding(.top, 8)
    }
 
}

struct Recents_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

