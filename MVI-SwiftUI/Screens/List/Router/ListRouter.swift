//
//  ListRouter.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Router

struct ListRouter: RouterProtocol {
	typealias RouterEventsType = RouterEvents<ScreenType, AlertType>

	let routerEvents: RouterEventsType
    let intent: ListIntentProtocol
}

// MARK: - Screens

extension ListRouter {
    enum ScreenType: RouterScreenProtocol {
        case videoPlayer(title: String, url: URL)
    }

	func getRouteType(for type: ScreenType) -> RouterScreenPresentationType {
		switch type {
		case .videoPlayer:
			return .navigationLink
		}
	}

    @ViewBuilder
    func makeScreen(for type: ScreenType) -> some View {
        switch type {
        case let .videoPlayer(title, url):
            ItemView.build(data: .init(title: title, url: url))
        }
    }

    func onDismiss(screenType: ScreenType) {}
}


// MARK: - Alerts

extension ListRouter {
	enum AlertType: RouterAlertScreenProtocol {
		case error(title: String, message: String)
	}

	func makeTitle(for type: AlertType) -> Text? {
		switch type {
		case let .error(title, _):
			return Text(title)
		}
	}

	func makeMessage(for type: AlertType) -> some View {
		switch type {
		case let .error(_, message):
			return Text(message)
		}
	}
	
	func makeActions(for type: AlertType) -> some View {
		Text("OK")
	}
}
