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

    private let model: ItemModelActionsProtocol
    private let externalData: ExternalData

    init(model: ItemModelActionsProtocol, externalData: ExternalData) {
        self.externalData = externalData
        self.model = model
    }
}

// MARK: - Public

extension ItemIntent: ItemIntentProtocol {

    func viewOnAppear() {
        model.setupScreen(url: externalData.url, title: externalData.title)
        model.play()
    }

    func didTapPlaying() {
        model.togglePlaing()
    }
}

// MARK: - Helper classes

extension ItemIntent {
    struct ExternalData {
        let title: String
        let url: URL
    }
}
