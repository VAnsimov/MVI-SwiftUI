//
//  RouterNavigationStackModifier.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

protocol RouterNavigationStackScreenProtocol {}

struct RouterNavigationStackModifier<Screen, ScreenType> where Screen: View, ScreenType: RouterNavigationStackScreenProtocol {
    
    // MARK: Public
    
    let publisher: AnyPublisher<ScreenType, Never>
    var screen: (ScreenType) -> Screen
    let onDismiss: ((ScreenType) -> Void)?
    
    // MARK: Private
    
    @State private var screenType: ScreenType?
}

// MARK: - ViewModifier

extension RouterNavigationStackModifier: ViewModifier {

    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .navigationDestination(isPresented: Binding<Bool>(
                    get: { screenType != nil },
                    set: {
                        if !$0 {
                            if let type = screenType { onDismiss?(type) }
                            screenType = nil
                        }
                    }), destination: {
                        if let type = screenType {
                            screen(type)
                        } else {
                            EmptyView()
                        }
                    })
                .onReceive(publisher) { screenType = $0 }
        } else {
            content
        }
    }
}
