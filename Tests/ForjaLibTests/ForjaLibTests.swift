import XCTest
@testable import ForjaLib

final class ForjaLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ForjaLib().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
