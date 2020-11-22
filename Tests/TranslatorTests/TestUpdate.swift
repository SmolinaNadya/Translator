@testable import Translator
import XCTest
class TestUpdate: XCTestCase {
    private var update: Update!
    private var getterData: GetDataMock!
    private var writer: WriterDataMock!

    override func setUp() {
        super.setUp()
        getterData = GetDataMock()
        writer = WriterDataMock()
        update = Update(getterData: getterData, writer: writer)
    }
    override func tearDown() {
        update = nil
        getterData = nil
        writer = nil
        super.tearDown()
    }
    func testUpdateWithAllKey() throws {
        let result = update.update(newWord: "Night", key: "night", language: "en")
        XCTAssertEqual(result, Result.updateSuccess)
    }
    
    static var allTests = [
        ("testUpdateWithAllKey", testUpdateWithAllKey)
    ]
}