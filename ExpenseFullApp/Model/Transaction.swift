//
//  Transaction.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 18/12/23.
//

import SwiftUI

struct Transaction : Identifiable {
    let id: UUID = .init()
    // Properties
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
 
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    // Extracting Color value from tintColor String
    var color: Color {
        return tints.first(where: { $0.color == tintColor})?.value ?? appTint
    }
    
}

// Sample Transaction for UI Building
var sampleTransaction: [Transaction] = [
    .init(title: "Gajian", remarks: "PT. Berkah Indonesia", amount: 3000, dateAdded: .now, category: .income, tintColor: tints.randomElement()!),
    .init(title: "Umraah", remarks: "El-Tartil", amount: 7000, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Travelling", remarks: "Bali", amount: 2000, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Setup PC", remarks: "Gaming", amount: 1000, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!)
]

func removeTransaction(with transactionId: String) {
    guard let index = sampleTransaction.firstIndex(where: {$0.id.uuidString == transactionId}) else { return }
    sampleTransaction.remove(at: index)
}
