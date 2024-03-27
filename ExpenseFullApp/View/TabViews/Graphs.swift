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
    // @Query(animation: .snappy) private var transactions: [Transaction]
    @State private var chartGroups: [ChartGroup] = []
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                Chart {
                    ForEach(chartGroups) { group in
                        ForEach(group.categories) { chart in
                            BarMark(
                                x: .value("Month", format(date: group.date, format: "MMM yy")),
                                y: .value(chart.category.rawValue, chart.totalValue),
                                width: 20
                            )
                            .position(by: .value("Category", chart.category), axis: .horizontal)
                        }
                    }
                }
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
