//___FILEHEADER___

import SwiftUI
import DesignSystem

protocol ___VARIABLE_sceneName___MapperProtocol {
    func getDefaultViewState() -> ___VARIABLE_sceneName___View.ViewState
}

class ___VARIABLE_sceneName___Mapper {
    init() {}
}

// MARK: - Public

extension ___VARIABLE_sceneName___Mapper: ___VARIABLE_sceneName___MapperProtocol {

    func getDefaultViewState() -> ___VARIABLE_sceneName___View.ViewState {
        ___VARIABLE_sceneName___View.ViewState(
           text: ""
       )
    }
}
