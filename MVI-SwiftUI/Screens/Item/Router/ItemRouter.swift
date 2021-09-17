//
//  ItemRouter.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

struct ItemRouter: View {

    // MARK: Public

    let routePublisher: AnyPublisher<ScreenType, Never>

    // MARK: Private

    @Environment(\.presentationMode) private var presentationMode

    // MARK: Life cycle

    var body: some View {
        Router(routePublisher: routePublisher) { screenType, active in
            VStack {
                NavigationLink("", destination: EmptyView(), isActive: .init(get: { false }, set: { _ in }))
            }
        }.onReceive(routePublisher) {
            guard case .exit = $0 else { return }
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - Helper classes

extension ItemRouter {
    enum ScreenType: ScreenKey {
        case exit

        var key: String {
            switch self {
            case .exit: return .screenExitKey
            }
        }
    }
}

// MARK: - Extensions

private extension String {
    static var screenExitKey: String { "VideoPlayerKey" }
}
