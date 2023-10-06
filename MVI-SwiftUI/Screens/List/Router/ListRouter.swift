//
//  ListRouter.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import RouterModifier

struct ListRouter: RouterModifierProtocol {
	typealias RouterEventsType = RouterEvents<ListRouterScreenType, ListRouterAlertType>

	let routerEvents: RouterEventsType
    let intent: ListIntentProtocol
}

// MARK: - Screens

enum ListRouterScreenType: RouterScreenProtocol {
	case videoPlayer(title: String, url: URL)
}

extension ListRouter {

	func getScreenPresentationType(for type: ListRouterScreenType) -> RouterScreenPresentationType {
		switch type {
		case .videoPlayer:
			return .navigationLink
		}
	}

    @ViewBuilder
    func getScreen(for type: ListRouterScreenType) -> some View {
        switch type {
        case let .videoPlayer(title, url):
            ItemView.build(data: .init(title: title, url: url))
        }
    }

    func onScreenDismiss(type: ListRouterScreenType) {}
}


// MARK: - Alerts

enum ListRouterAlertType: RouterAlertScreenProtocol {
	case error(title: String, message: String)
}

extension ListRouter {

	func getAlertTitle(for type: ListRouterAlertType) -> Text? {
		switch type {
		case let .error(title, _):
			return Text(title)
		}
	}

	func getAlertMessage(for type: ListRouterAlertType) -> some View {
		switch type {
		case let .error(_, message):
			return Text(message)
		}
	}
	
	func getAlertActions(for type: ListRouterAlertType) -> some View {
		Text("OK")
	}
}
