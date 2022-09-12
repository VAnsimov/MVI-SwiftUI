//___FILEHEADER___

import SwiftUI

class ___VARIABLE_sceneName___Intent {

    // MARK: Model

    private weak var model: ___VARIABLE_sceneName___ModelActionsProtocol?
    private weak var routeModel: ___VARIABLE_sceneName___ModelRouterProtocol?

    // MARK: Busines Data

    private let externalData: ExternalData

    // MARK: Life cycle

    init(model: ___VARIABLE_sceneName___ModelActionsProtocol & ___VARIABLE_sceneName___ModelRouterProtocol,
         externalData: ExternalData) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
    }

}

// MARK: - Public

extension ___VARIABLE_sceneName___Intent: ___VARIABLE_sceneName___IntentProtocol {

    func viewOnAppear() {
        model?.dispalyLoading()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.model?.dispaly(content: Int.random(in: 0 ..< 100))
        }
    }

    func viewOnDisappear() {}
}

// MARK: - Helper classes

extension ___VARIABLE_sceneName___Intent {
    struct ExternalData {}
}
