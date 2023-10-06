//
//  RouterScreenProtocol.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

public protocol RouterScreenProtocol: RouterNavigationDestinationScreenProtocol & RouterNavigationLinkScreenProtocol & RouterSheetScreenProtocol {}

public enum RouterScreenPresentationType {
    case sheet
    case fullScreenCover

	/// For NavigationStack or NavigationSplitView
	@available(iOS 16.0, *, macOS 13.0, *)
    case navigationDestination

	/// For NavigationView
	@available(iOS, introduced: 13.0, deprecated: 16.0, message: "use .navigationDestination, inside a NavigationStack or NavigationSplitView")
	@available(macOS, introduced: 10.15, deprecated: 13.0, message: "use .navigationDestination, inside a NavigationStack or NavigationSplitView")
	case navigationLink
}

