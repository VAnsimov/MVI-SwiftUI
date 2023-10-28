//
//  RouterAlertModifier.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

public protocol RouterAlertScreenProtocol {}

struct RouterAlertModifier<Actions, Message, ScreenType>
where Actions: View, Message: View, ScreenType: RouterAlertScreenProtocol {

    // MARK: Public
    
    let publisher: AnyPublisher<ScreenType, Never>
	let title: (ScreenType) -> Text?
	let message: (ScreenType) -> Message?
    let actions: (ScreenType) -> Actions?


    // MARK: Private
    
    @State 
	private var screenType: ScreenType?
	private var isPresented: Binding<Bool> {
		Binding(
			get: { screenType != nil },
			set: { if !$0 { screenType = nil } }
		)
	}

	private var titleText: Text {
		guard let screenType else { return Text("") }
		return title(screenType) ?? Text("")
	}

	@ViewBuilder
	private var messageView: some View {
		if let type = screenType, let messageView = message(type) {
			messageView
		} else {
			EmptyView()
		}
	}
}

// MARK: - ViewModifier

extension RouterAlertModifier: ViewModifier {

	func body(content: Content) -> some View {
        content
            .alert(
                titleText,
                isPresented: isPresented,
                actions: {
                    if let type = screenType, let actionsView = actions(type) {
                        actionsView
                    } else {
                        EmptyView()
                    }
                },
                message: { messageView }
            )
            .onReceive(publisher) { screenType = $0 }
    }
}
