//
//  ListView+Build.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

extension ListView {
    
    static func build(data: ListTypes.Intent.ExternalData) -> some View {
        let model = ListModel()
        let intent = ListIntent(model: model, externalData: data, urlService: WWDCUrlService())
        let container = MVIContainer(
            intent: intent as ListIntentProtocol,
            model: model as ListModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        let view = ListView(container: container)
        return view
    }
}
