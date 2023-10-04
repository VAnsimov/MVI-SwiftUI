//___FILEHEADER___

public protocol RouterScreenProtocol: RouterNavigationDestinationScreenProtocol & RouterNavigationLinkScreenProtocol & RouterSheetScreenProtocol {}

public enum RouterScreenPresentationType {
	case sheet
	case fullScreenCover

	/// For iOS 16.* and NavigationStack or NavigationSplitView
	case navigationDestination

	/// For iOS 13.*  - 15.* and NavigationView
	case navigationLink
}

