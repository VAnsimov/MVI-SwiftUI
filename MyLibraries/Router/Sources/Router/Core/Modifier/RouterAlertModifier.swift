//
//  RouterAlertModifier.swift
//  Router
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
	let oldAlert: (ScreenType) -> Alert

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
		if #available(iOS 15.0, *) {
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
					message: {
						messageView
					}
				)
				.onReceive(publisher) { screenType = $0 }
		} else {
			content
				.alert(isPresented: isPresented, content: {
					if let type = screenType {
						oldAlert(type)
					} else {
						Alert(title: Text(""))
					}
				})
				.onReceive(publisher) { screenType = $0 }
		}
    }
}
