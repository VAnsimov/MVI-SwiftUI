//
//  WWDCUrlServiceProtocol.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import Foundation

protocol WWDCUrlServiceProtocol {
    func fetch(contnet: WWDCUrlType, completion: (Result<[WWDCUrlContent], WWDCUrlError>) -> Void)
}

enum WWDCUrlType {
    case swiftUI
}

enum WWDCUrlError: Error {
    case emptyData
}

struct WWDCUrlContent {
    var id: String { title + url.absoluteString }
    let title: String
    let url: URL
}
