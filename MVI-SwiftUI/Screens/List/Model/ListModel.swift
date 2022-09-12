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

    @Published var contentState: ListTypes.Model.ContentState = .loading

    let loadingText = "Loading"
    let navigationTitle = "SwiftUI Videos"
    let routerSubject = ListRouter.Subjects()
}

// MARK: - Actions Protocol

extension ListModel: ListModelActionsProtocol {

    func dispalyLoading() {
        contentState = .loading
    }

    func update(contents: [WWDCUrlContent]) {
        let urlContents = contents
            .map { ListUrlContentView.StateViewModel(id: $0.id, title: $0.title) }
            .sorted(by: { $0.title < $1.title  })
        contentState = .content(urlContents: urlContents)
    }

    func dispalyError(_ error: Error) {
        contentState = .error(text: "Fail")
    }
}

// MARK: - Route Protocol

extension ListModel: ListModelRouterProtocol {

    func routeToVideoPlayer(content: WWDCUrlContent) {
        routerSubject.screen.send(.videoPlayer(title: content.title, url: content.url))
    }
}

// MARK: - Helper classes

extension ListTypes.Model {
    enum ContentState {
        case loading
        case content(urlContents: [ListUrlContentView.StateViewModel])
        case error(text: String)
    }
}
