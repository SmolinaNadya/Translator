@testable import Translator
import XCTest
class TestDelete: XCTestCase {
    private var delete: Delete!
    private var getterData: GetDataMock!
    //private var words: [String: [String: String]] 
    private var writer: WriterDataMock!

    override func setUp() {
        super.setUp()
        getterData = GetDataMock()
        writer = WriterDataMock()
        delete = Delete(getterData: getterData, writer: writer)
    }
    override func tearDown() {
        delete = nil
        getterData = nil
        writer = nil
        super.tearDown()
    }
    func testDeleteWithAllKeys() throws {
        let result = delete.delete(key: "day", language: "pt")
        XCTAssertEqual(result, Result.deleteSuccess)
    }
    func testDeleteWithKey() throws {
        let result = delete.delete(key: "home", language: nil)
        XCTAssertEqual(result, Result.deleteSuccess)
    }
    func testDeleteWithLanguage() throws {
        let result = delete.delete(key: nil, language: "pt")
        XCTAssertEqual(result, Result.deleteSuccess)
    }
    func testDeleteNoArguments() throws {
        let result = delete.delete(key: nil, language: nil)
        XCTFail("Для удаления введите ключ -k и -l")
    }

    static var allTests = [
         ("testDeleteWithAllKeys", testDeleteWithAllKeys),
         ("testDeleteWithKey", testDeleteWithKey),
         ("testDeleteWithLanguage", testDeleteWithLanguage),
         ("testDeleteNoArguments", testDeleteNoArguments)
    ]
}