//
//  ItemIntent.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

class ItemIntent {

    // MARK: Model

    private weak var model: ItemModelActionsProtocol?
    private weak var routeModel: ItemModelRouterProtocol?

    // MARK: Business Data

    private let externalData: ItemTypes.Intent.ExternalData

    // MARK: Life cycle

    init(model: ItemModelActionsProtocol & ItemModelRouterProtocol,
         externalData: ItemTypes.Intent.ExternalData) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
    }

}

// MARK: - Public

extension ItemIntent: ItemIntentProtocol {

    func viewOnAppear() {
        model?.setupScreen(url: externalData.url, title: externalData.title)
        model?.play()
    }

    func viewOnDisappear() {
        model?.stop()
    }

    func didTapPlaying() {
        model?.togglePlaing()
    }
}

// MARK: - Helper classes

extension ItemTypes.Intent {
    struct ExternalData {
        let title: String
        let url: URL
    }
}
