//
//  ListIntent.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

class ListIntent {

    private weak var model: ListModelActionsProtocol?
    private let externalData: ExternalData
    private let urlService: WWDCUrlServiceProtocol
    private var contents: [WWDCUrlContent] = []

    init(model: ListModelActionsProtocol,
         externalData: ExternalData,
         urlService: WWDCUrlServiceProtocol) {
        self.externalData = externalData
        self.model = model
        self.urlService = urlService
    }
}

// MARK: - Public

extension ListIntent: ListIntentProtocol {

    func viewOnAppear() {
        model?.dispalyLoading()

        urlService.fetch(contnet: .swiftUI) { [weak self] result in
            switch result {
            case let .success(contents):
                self?.contents = contents
                self?.model?.update(contents: contents)

            case let .failure(error):
                self?.model?.dispalyError(error)
            }
        }
    }

    func onTapUrlContent(id: String) {
        guard let content = contents.first(where: { $0.id == id }) else { return }
        model?.routeToVideoPlayer(content: content)
    }
}

// MARK: - Helper classes

extension ListIntent {
    struct ExternalData {}
}
