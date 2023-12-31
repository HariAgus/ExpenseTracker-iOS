//
//  DateFilterView.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 31/12/23.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    
    var onSubmit: (Date, Date) -> ()
    var onClose: () -> ()
    var body: some View {
        VStack(spacing: 15) {
            DatePicker("Start Date", selection: $start, displayedComponents: [.date])
            
            DatePicker("End Date", selection: $end, displayedComponents: [.date])
            
            HStack(spacing: 15) {
                Button("Cancel") {
                    onClose()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 6))
                .tint(.red)
                
                Button("Filter") {
                    onSubmit(start, end)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 6))
                .tint(appTint)
            }
            .padding(.top, 10)
        }
        .padding(16)
        // .background(.bar, in: .rect()
        .background(.bar)
        .cornerRadius(10)
        .padding(.horizontal, 30)
    }
}
