// Copyright (c) 2018-2020 XMLCoder contributors
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
//  Created by Vincent Esche on 12/19/18.
//

import XCTest
@testable import XMLCodable

class EmptyTests: XCTestCase {
    struct Container: Codable, Equatable {
        // empty

        func encode(to _: Encoder) throws {
            // do nothing
        }
    }

    func testAttribute() throws {
        let decoder = XMLDecoder()
        let encoder = XMLEncoder()

        encoder.nodeEncodingStrategy = .custom { _, _ in
            { _ in .attribute }
        }

        XCTAssertThrowsError(try decoder.decode(Container.self, from: Data()))

        let encoded = try encoder.encode(Container(), withRootKey: "container")
        XCTAssertEqual(String(data: encoded, encoding: .utf8)!, "<container />")
    }

    func testElement() throws {
        let decoder = XMLDecoder()
        let encoder = XMLEncoder()

        encoder.outputFormatting = [.prettyPrinted]

        XCTAssertThrowsError(try decoder.decode(Container.self, from: Data()))

        let encoded = try encoder.encode(Container(), withRootKey: "container")
        XCTAssertEqual(String(data: encoded, encoding: .utf8)!, "<container />")
    }
}
