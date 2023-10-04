//
//  RouterNavigationLinkModifier.swift
//  Router
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

public protocol RouterNavigationLinkScreenProtocol {}

struct RouterNavigationLinkModifier<Screen, ScreenType>
where Screen: View, ScreenType: RouterNavigationLinkScreenProtocol {

    // MARK: Public
    
    let publisher: AnyPublisher<ScreenType, Never>
    var screen: (ScreenType) -> Screen
    let onDismiss: ((ScreenType) -> Void)?
    
    // MARK: Private
    
    @State
	private var screenType: ScreenType?
	private var isActive: Binding<Bool> {
		Binding(
			get: { screenType != nil },
			set: {
				if !$0 {
					if let type = screenType { onDismiss?(type) }
					screenType = nil
				}
			}
		)
	}
}

// MARK: - ViewModifier

extension RouterNavigationLinkModifier: ViewModifier {

	func body(content: Content) -> some View {
		ZStack {
			NavigationLink(
				"",
				isActive: isActive,
				destination: {
					if let type = screenType {
						screen(type)
					} else {
						EmptyView()
					}
				}
			)
			content
		}
		.onReceive(publisher) { screenType = $0 }
    }
}
