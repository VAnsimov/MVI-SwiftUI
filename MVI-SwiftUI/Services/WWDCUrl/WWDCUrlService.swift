//
//  WWDCUrlService.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import Foundation

class WWDCUrlService {}

// MARK: - Public

extension WWDCUrlService: WWDCUrlServiceProtocol {

    func fetch(contnet: WWDCUrlType, completion: (Result<[WWDCUrlContent], WWDCUrlError>) -> Void) {
        let plist = getPlist(withName: contnet.plistName)

        let contents: [WWDCUrlContent] = plist?.compactMap {
            guard let strUrl = $1 as? String,
                  let url = URL(string: strUrl)
            else { return nil }

            return WWDCUrlContent(title: $0, url: url)
        } ?? []

        if contents.isEmpty {
            completion(.failure(.emptyData))
        } else {
            completion(.success(contents))
        }
    }
}

// MARK: - Private

private extension WWDCUrlService {

    func getPlist(withName name: String) -> [String: Any]? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "plist"),
              let data = try? Data(contentsOf:url),
              let propertyList = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)
        else { return nil }

        return propertyList as? [String: Any]
    }
}

private extension WWDCUrlType {
    var plistName: String {
        switch self {
        case .swiftUI: return "SwiftUIData"
        }
    }
}
