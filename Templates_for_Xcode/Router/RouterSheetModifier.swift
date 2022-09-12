//
//  RouterSheetModifier.swift
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

protocol RouterSheetScreenProtocol {}

struct RouterSheetModifier<Screen, ScreenType> where Screen: View, ScreenType: RouterSheetScreenProtocol {

    // MARK: Public

    var isFullScreenCover: Bool = false
    let publisher: AnyPublisher<ScreenType, Never>
    var screen: (ScreenType) -> Screen
    let onDismiss: ((ScreenType) -> Void)?


    // MARK: Private

    @State private var screenType: ScreenType?
}

// MARK: - ViewModifier

extension RouterSheetModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onReceive(publisher) { screenType = $0 }
            .if(!isFullScreenCover) { view in
                view.sheet(
                    isPresented: Binding<Bool>(
                        get: { screenType != nil },
                        set: {
                            if !$0 {
                                if let type = screenType { onDismiss?(type) }
                                screenType = nil
                            }
                        }),
                    content: {
                        if let type = screenType {
                            screen(type)
                        } else {
                            EmptyView()
                        }
                    })
            }
            .if(isFullScreenCover) { view in
                view.fullScreenCover(
                    isPresented: Binding<Bool>(
                        get: { screenType != nil },
                        set: {
                            if !$0 {
                                if let type = screenType { onDismiss?(type) }
                                screenType = nil
                            }
                        }),
                    content: {
                        if let type = screenType {
                            screen(type)
                        } else {
                            EmptyView()
                        }
                    })
            }

    }
}

// MARK: - Extensions

private extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
