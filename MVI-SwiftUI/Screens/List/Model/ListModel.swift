//
//  ListModel.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import UIKit
import Combine

final class ListModel: ObservableObject, ListModelStatePotocol {

    @Published var state: ScreenState = .loading

    let loadingText = "Loading"
    let navigationTitle = "Loading"
    let routerSubject = PassthroughSubject<ListRouter.ScreenType, Never>()
}

// MARK: - Helper classes

extension ListModel {
    enum ScreenState {
        case loading
        case content(urlContents: [ListUrlContentView.StateViewModel])
        case error(text: String)
    }
}

// MARK: - Actions Protocol

extension ListModel: ListModelActionsProtocol {

    func dispalyLoading() {
        state = .loading
    }

    func update(contents: [WWDCUrlContent]) {
        let urlContents = contents
            .map { ListUrlContentView.StateViewModel(id: $0.id, title: $0.title) }
            .sorted(by: { $0.title > $1.title  })
        state = .content(urlContents: urlContents)
    }

    func dispalyError(_ error: Error) {
        state = .error(text: "Fail")
    }

    func routeToVideoPlayer(content: WWDCUrlContent) {
        routerSubject.send(.videoPlayer(title: content.title, url: content.url))
    }
}
