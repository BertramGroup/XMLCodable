// Copyright (c) 2018-2020 XMLCoder contributors
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
//  Created by Vincent Esche on 12/18/18.
//

import XCTest
@testable import XMLCodable

class KeyedBoxTests: XCTestCase {
    typealias Boxed = KeyedBox

    let box = Boxed(
        elements: [("foo", StringBox("bar")), ("baz", IntBox(42))] as [(String, Box)],
        attributes: [("baz", StringBox("blee"))]
    )

    func testIsNull() {
        let box = Boxed()
        XCTAssertEqual(box.isNull, false)
    }

    func testUnbox() {
        let (elements, attributes) = box.unboxed

        XCTAssertEqual(elements.count, 2)
        XCTAssertEqual(elements["foo"].first as? StringBox, StringBox("bar"))
        XCTAssertEqual(elements["baz"].first as? IntBox, IntBox(42))

        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(attributes["baz"].first as? StringBox, StringBox("blee"))
    }

    func testXMLString() {
        XCTAssertEqual(box.xmlString, nil)
    }

    func testDescription() {
        XCTAssertEqual(
            box.description,
            "{attributes: [\"baz\": blee], elements: [\"foo\": bar, \"baz\": 42]}"
        )
    }

    func testSequence() {
        var sortedElements: [(String, Box)] = Array(box.elements)
        sortedElements.sort { $0.0 < $1.0 }

        XCTAssertEqual(sortedElements[0].0, "baz")
        XCTAssertEqual(sortedElements[1].0, "foo")
    }

    func testSubscript() {
        let elements: [(String, Box)] = [("foo", StringBox("bar")), ("baz", IntBox(42))]
        var box = Boxed(
            elements: elements,
            attributes: [("baz", StringBox("blee"))]
        )
        box.elements.append(NullBox(), at: "bar")
        XCTAssertEqual(box.elements.count, 3)
        XCTAssertEqual(box.elements["bar"].first as? NullBox, NullBox())
    }
}
