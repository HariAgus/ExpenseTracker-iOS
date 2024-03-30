//
//  Recents.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 18/12/23.
//

import SwiftUI
import SwiftData

@available(iOS 17, *)
struct Dashboard: View {
    
    @Environment(\.modelContext) private var context
    
    // User properties
    @AppStorage("userName") private var userName: String = ""
    
    // View
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var showFilterView: Bool = false
    @State private var selectedCategory: Category = .income
    
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
                            
                            FilterTransactionsView(startDate: startDate, endDate: endDate) { transactions in
                                // Card View
                                CardView(
                                    income: total(transactions, category: .income),
                                    expense: total(transactions, category: .expense)
                                )
                                
                                // Custom Segemented Control
                                CustomSegmentedControl()
                                    .padding(.bottom, 10)
                                
                                // Items
                                ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                                    NavigationLink(value: transaction) {
                                        TransactionCardView(transaction: transaction)
                                    }
                                    .buttonStyle(.plain)
                                    .contextMenu {
                                        Button {
                                            context.delete(transaction)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
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
                .navigationDestination(for: Transaction.self) { transaction in
                    TransactionView(editTransaction: transaction)
                }
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
                TransactionView()
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
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
        
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

@available(iOS 17.0, *)
struct Recents_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

