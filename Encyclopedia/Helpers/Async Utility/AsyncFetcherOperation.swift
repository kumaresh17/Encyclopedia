//
//  AsyncFetcherOperation.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 01/01/2022.
//

/*
Abstract:
An `Operation` subclass used by `AsyncFetcher`
*/

import Foundation
import UIKit

class AsyncFetcherOperation: Operation {
    // MARK: Properties

    /// The `UUID` that the operation is fetching data for.
    let identifier: UUID
    let ImageUrl: URL

    /// The `DisplayImage` that has been fetched by this operation.
    private(set) var fetchedData: DisplayImage?

    // MARK: Initialization

    init(identifier: UUID , url:URL) {
        self.identifier = identifier
        self.ImageUrl = url
       
    }

    // MARK: Operation overrides

    override func main() {
        guard !isCancelled else { return }
        fetchedData = DisplayImage()
        if let data = try? Data(contentsOf: self.ImageUrl) {
            if let image = UIImage(data: data) {
                fetchedData?.imageCat = image
            }
        }
    }
}

