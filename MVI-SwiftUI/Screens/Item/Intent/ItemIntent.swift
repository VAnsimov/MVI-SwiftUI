//
//  ItemIntent.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine


import SwiftUI

class ItemIntent {

    // MARK: Model

    private let model: ItemModelActionsProtocol
    private let routeModel: ItemModelRouterProtocol

    // MARK: Busines Data

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
        model.setupScreen(url: externalData.url, title: externalData.title)
        model.play()
    }

    func viewonDisappear() {
        model.stop()
    }

    func didTapPlaying() {
        model.togglePlaing()
    }
}

// MARK: - Helper classes

extension ItemTypes.Intent {
    struct ExternalData {
        let title: String
        let url: URL
    }
}
