//___FILEHEADER___

import Combine

public struct RouterEvents<ScreenType, AlertType>
where ScreenType: RouterScreenProtocol, AlertType: RouterAlertScreenProtocol {

	let screenSubject = PassthroughSubject<ScreenType, Never>()
	let alertSubject = PassthroughSubject<AlertType, Never>()
	let dismissSubject = PassthroughSubject<Void, Never>()

	public init() {}

	public func routeTo(_ type: ScreenType) {
		screenSubject.send(type)
	}

	public func presentAlert(_ type: AlertType) {
		alertSubject.send(type)
	}

	public func dismiss() {
		dismissSubject.send()
	}
}
