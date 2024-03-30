//
//  Graphs.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 18/12/23.
//

import SwiftUI
import Charts
import SwiftData

@available(iOS 17.0, *)
struct Graphs: View {
    
    // View Properties
    @Query(animation: .snappy) private var transactions: [Transaction]
    @State private var chartGroups: [ChartGroup] = []
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ChartView()
                    .frame(height: 200)
                    .padding(10)
                    .padding(.top,10)
                    .background(.background, in: .rect(cornerRadius: 10))
            }
            .padding(15)
        }
        .navigationTitle("Graphs")
        .background(.gray.opacity(0.15))
        .onAppear {
            createChartGroup()
        }
    }
    
    @ViewBuilder
    func ChartView() -> some View {
        // Chart View
        Chart {
            ForEach(chartGroups) { group in
                ForEach(group.categories) { chart in
                    BarMark(
                        x: .value("Month", format(date: group.date, format: "MMM yy")),
                        y: .value(chart.category.rawValue, chart.totalValue),
                        width: 20
                    )
                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
                }
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        .chartLegend(position: .bottom, alignment: .trailing)
        .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient])
    }
    
    func createChartGroup() {
        Task.detached(priority: .high) {
            let calendar = Calendar.current
            
            let groupByDate = Dictionary(grouping: transactions) { transaction in
                let components = calendar.dateComponents([.month, .year], from: transaction.dateAdded)
                
                return components
            }
            
            // Sorting Groups By Date
            let sortingGroups = groupByDate.sorted {
                let startDate = calendar.date(from: $0.key) ?? .init()
                let endDate = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(startDate, to: endDate, toGranularity: .day) == .orderedDescending
            }
            
            let chartGroups = sortingGroups.compactMap { dict -> ChartGroup in
                let date = calendar.date(from: dict.key) ?? .init()
                let inconme = dict.value.filter({ $0.category == Category.income.rawValue})
                let expense = dict.value.filter({ $0.category == Category.expense.rawValue})
                
                // TODO : Continue this
                let incomeTotalValue = total(inconme, category: .income)
                let expenseTotalValue = total(expense, category: .expense)
                
                return .init(
                    date: date,
                    categories: [
                        .init(totalValue: incomeTotalValue, category: .income),
                        .init(totalValue: expenseTotalValue, category: .expense)
                    ],
                    totalIncome: incomeTotalValue,
                    totalExpense: expenseTotalValue
                )
            }
            
            // UI Must be updated on Main Thread
            await MainActor.run {
                self.chartGroups = chartGroups
            }
        }
    }
}

@available(iOS 17.0, *)
struct Graphs_Previews: PreviewProvider {
    static var previews: some View {
        Graphs()
    }
}
