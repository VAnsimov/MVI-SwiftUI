//
//  RouterNavigationDestinationModifier.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

public protocol RouterNavigationDestinationScreenProtocol {}

struct RouterNavigationDestinationModifier<ScreenView, ScreenType>
where ScreenView: View, ScreenType: RouterNavigationDestinationScreenProtocol {

    // MARK: Public
    
    let publisher: AnyPublisher<ScreenType, Never>
    var screen: (ScreenType) -> ScreenView
    let onDismiss: ((ScreenType) -> Void)?
    
    // MARK: Private
    
    @State 
	private var screenType: ScreenType?
	private var isPresented: Binding<Bool> {
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

extension RouterNavigationDestinationModifier: ViewModifier {

	func body(content: Content) -> some View {
        if #available(iOS 16.0, *, macOS 13.0, *) {
			content
				.navigationDestination(
					isPresented: isPresented,
					destination: {
						if let type = screenType {
							screen(type)
						} else {
							EmptyView()
						}
					}
				)
				.onReceive(publisher) { screenType = $0 }
		} else {
			content
		}
	}
}
