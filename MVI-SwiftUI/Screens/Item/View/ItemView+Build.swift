//
//  ItemView+Build.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

extension ItemView {

    static func build(data: ItemTypes.Intent.ExternalData) -> some View {
        let model = ItemModel()
        let intent = ItemIntent(model: model, externalData: data)
        let container = MVIContainer(
            intent: intent as ItemIntentProtocol,
            model: model as ItemModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        let view = ItemView(container: container)
        return view
    }
}
