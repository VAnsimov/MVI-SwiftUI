//
//  RouterDismissModifier.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

struct RouterDismissModifier: ViewModifier {

    // MARK: Public
    
    let publisher: AnyPublisher<Void, Never>
    
    // MARK: Private
    
    @Environment(\.presentationMode) 
	private var presentationMode

    // MARK: Life cycle
    
    func body(content: Content) -> some View {
        content
            .onReceive(publisher) { _ in
                presentationMode.wrappedValue.dismiss()
            }
    }
}
