//
//  ListIntent.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

class ListIntent {

    // MARK: Model

    private let model: ListModelActionsProtocol
    private let routeModel: ListModelRouterProtocol

    // MARK: Services

    private let urlService: WWDCUrlServiceProtocol

    // MARK: Busines Data

    private let externalData: ListTypes.Intent.ExternalData
    private var contents: [WWDCUrlContent] = []

    // MARK: Life cycle

    init(model: ListModelActionsProtocol & ListModelRouterProtocol,
         externalData: ListTypes.Intent.ExternalData,
         urlService: WWDCUrlServiceProtocol) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
        self.urlService = urlService
    }
}

// MARK: - Public

extension ListIntent: ListIntentProtocol {

    func viewOnAppear() {
        model.dispalyLoading()

        urlService.fetch(contnet: .swiftUI) { [weak self] result in
            switch result {
            case let .success(contents):
                self?.contents = contents
                self?.model.update(contents: contents)

            case let .failure(error):
                self?.model.dispalyError(error)
            }
        }
    }

    func onTapUrlContent(id: String) {
        guard let content = contents.first(where: { $0.id == id }) else { return }
        routeModel.routeToVideoPlayer(content: content)
    }
}

// MARK: - Helper classes

extension ListTypes.Intent {
    struct ExternalData {}
}
