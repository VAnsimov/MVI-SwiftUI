//___FILEHEADER___

import SwiftUI

class ___VARIABLE_sceneName___Intent {

    // Model
    private weak var model: ___VARIABLE_sceneName___ModelActionsProtocol?

    // Busines Data
    private let externalData: ___VARIABLE_sceneName___ExternalData

    // MARK: Life cycle

    init(
		model: ___VARIABLE_sceneName___ModelActionsProtocol,
		externalData: ___VARIABLE_sceneName___ExternalData
	) {
        self.externalData = externalData
        self.model = model
    }
}

// MARK: - Public

extension ___VARIABLE_sceneName___Intent: ___VARIABLE_sceneName___IntentProtocol {

    func viewOnAppear() {
        model?.displayLoading()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.model?.display(content: Int.random(in: 0 ..< 100))
        }
    }

    func viewOnDisappear() {}
}
