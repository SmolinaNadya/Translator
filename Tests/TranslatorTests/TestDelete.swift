@testable import Translator
import XCTest
final class TestDelete: XCTestCase {
    private var delete: Delete!
    private var getterData: GetDataMock!
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
        getterData.getDataResult = ["day":["ru":"День","en":"Day"],"home":["ru":"Дом","pt":"Dia"]]
        let results = delete.delete(key: "day", language: "en")
        XCTAssertEqual(results, Result.deleteSuccess)
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, ["day":["ru":"День"],"home":["ru":"Дом","pt":"Dia"]])
        XCTAssertEqual(getterData.getDataCallsCount, 1)  
    }
    func testDeleteWithKey() throws {
        getterData.getDataResult = ["home":["en":"Home"]]
        let result = delete.delete(key: "home", language: nil)
        XCTAssertEqual(result, Result.deleteSuccess)
        XCTAssertEqual(getterData.getDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, [:])
    }
    func testDeleteWithLanguage() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        let result = delete.delete(key: nil, language: "en")
        XCTAssertEqual(result, Result.deleteSuccess)
        XCTAssertEqual(getterData.getDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, ["home":["ru":"Дом"]])
    }
    func testDeleteNoArguments() throws {
        let result = delete.delete(key: nil, language: nil)
        XCTAssertEqual(result, Result.errorNotArguments)
        XCTAssertEqual(writer.writingDataCallsCount, 0)
    }

    static var allTests = [
         ("testDeleteWithAllKeys", testDeleteWithAllKeys),
         ("testDeleteWithKey", testDeleteWithKey),
         ("testDeleteWithLanguage", testDeleteWithLanguage),
         ("testDeleteNoArguments", testDeleteNoArguments)
    ]
}