//
//  View+Extension.swift
//  ExpenseFullApp
//
//  Created by Hari Agus Widakdo on 18/12/23.
//

import SwiftUI


extension View {
    @ViewBuilder
    func hSpacing(_ aligment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: aligment)
    }
    
    @ViewBuilder
    func vSpacing(_ aligment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: aligment)
    }
    
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        
        return .zero
    }
    
    func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func currencyString(_ value: Double, allowDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode =  "IDR"
        formatter.maximumFractionDigits = allowDigits
        
        return formatter.string(from: .init(value: value)) ?? ""
    }
    
    var currencySymbol: String {
        let locale = Locale.current
        
        return locale.currencySymbol ?? ""
    }
    
}
