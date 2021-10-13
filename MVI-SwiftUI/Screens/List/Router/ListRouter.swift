//
//  ListRouter.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

struct ListRouter: View {

    // MARK: Public

    let routePublisher: AnyPublisher<ScreenType, Never>

    // MARK: Life cycle

    var body: some View {
        Router(routePublisher: routePublisher) { screenType, active in
            VStack {
                NavigationLink("", destination: itemView(screenType: screenType),
                               isActive: active.isActive(key: .screenVideoPlayerKey))
            }
            .alert(isPresented: active.isActive(key: .screenAlertKey)) { alertView(screenType: screenType) }
        }
    }
}

// MARK: - Helper classes

extension ListRouter {

    enum ScreenType: ScreenKey {
        case videoPlayer(title: String, url: URL)
        case alert(title: String, message: String?)

        var key: String {
            switch self {
            case .videoPlayer: return .screenVideoPlayerKey
            case .alert: return .screenAlertKey
            }
        }
    }
}

// MARK: - Private - Views

extension ListRouter {

    @ViewBuilder
    func itemView(screenType: ScreenType?) -> some View {
        if case let .videoPlayer(title, url) = screenType {
            ItemView.build(data: .init(title: title, url: url))
        } else {
            EmptyView()
        }
    }

    func alertView(screenType: ScreenType?) -> Alert {
        guard case let .alert(title, message) = screenType else { return Alert(title: Text("")) }
        return Alert(title: Text(title), message: message?.toText(), dismissButton: .cancel())
    }
}

// MARK: - Extensions

private extension String {
    static var screenVideoPlayerKey: String { "VideoPlayerKey" }
    static var screenAlertKey: String { "AlertKey" }

    func toText() -> Text { Text(self) }
}
