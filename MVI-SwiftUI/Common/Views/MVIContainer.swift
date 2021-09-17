//
//  Router.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

class MVIContainer<Intent, Model: ObservableObject>: ObservableObject {

    // MARK: Public

    let intent: Intent
    let model: Model

    // MARK: private

    private var cancellable: Set<AnyCancellable> = []

    // MARK: Life cycle

    init(intent: Intent, model: Model) {
        self.intent = intent
        self.model = model

        model.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async { self?.objectWillChange.send() }
        }.store(in: &cancellable)
    }
}
