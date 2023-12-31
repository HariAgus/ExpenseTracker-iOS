//
//  TransactionCardView.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 30/12/23.
//

import SwiftUI

struct TransactionCardView: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            Text("\(String(transaction.title.prefix(1)))")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .background(transaction.color.gradient, in: Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .foregroundStyle(Color.primary)
                
                Text(transaction.remarks)
                    .font(.caption)
                    .foregroundStyle(Color.primary)
                
                Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            .hSpacing(.leading)
            
            Text(currencyString(transaction.amount, allowDigits: 1))
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
//        .background(Circle().fill(.white))
        // .background(.white)
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCardView(transaction: sampleTransaction[0])
    }
}
