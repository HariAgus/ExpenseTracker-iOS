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
    
}
