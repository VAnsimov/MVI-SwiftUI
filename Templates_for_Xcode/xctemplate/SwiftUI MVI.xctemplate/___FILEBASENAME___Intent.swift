//___FILEHEADER___

import SwiftUI
import DesignSystem

class ___VARIABLE_sceneName___ViewModel: ObservableObject {

    // State
    @Published var state: ___VARIABLE_sceneName___View.ViewState
    var routerEvents = ___VARIABLE_sceneName___Router.RouterEventsType()

    // Dependencies
    private let mapper: ___VARIABLE_sceneName___MapperProtocol

    // Busines Data
    private let externalData: ExternalData

    // MARK: Life cycle

    init(
        externalData: ___VARIABLE_sceneName___ViewModel.ExternalData,
        mapper: ___VARIABLE_sceneName___MapperProtocol
    ) {
        self.externalData = externalData
        self.mapper = mapper

        state = mapper.getDefaultViewState()
    }
}

// MARK: - Public

extension ___VARIABLE_sceneName___ViewModel {

    func viewOnAppear() {
        state.text = "Hello, World!"
    }

    func viewOnDisappear() {}
}

// MARK: - Helper classes

extension ___VARIABLE_sceneName___ViewModel {
    struct ExternalData {}
}
