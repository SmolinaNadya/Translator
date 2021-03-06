@testable import Translator
import XCTest
final class TestSearch: XCTestCase {
    private var search: Search!
    private var getterData: GetDataMock!
    private var output: OutputDataMock!
    override func setUp() {
        super.setUp()
        getterData = GetDataMock()
        output = OutputDataMock()
        search = Search(getterData: getterData, outputData: output)
    }
   override func tearDown() {
        search = nil
        getterData = nil
        output = nil
        super.tearDown()
    }
    func testSearchKeyAndLanguage() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        let found = search.search(key: "home", language: "ru")
        guard case Result.success(let value) = found else {
            XCTFail("Ошибка поиска")
            return
        }
        XCTAssertEqual(value, "Дом")
        XCTAssertEqual(getterData.getDataCallsCount, 1)
    }
    func testSearchKey() throws {
        getterData.getDataResult = ["day":["en":"Day","ru":"День"]]
        output.outputLanguageAndValueResult = "en:Day\nru:День"
        let found = search.search(key: "day", language: nil)
        guard case Result.success(let value) = found else {
            XCTFail("Ошибка поиска")
            return
        }
        XCTAssertEqual(getterData.getDataCallsCount, 1)
        XCTAssertEqual(value, "en:Day\nru:День")
        XCTAssertEqual(output.outputLanguageAndValueCallsCount, 1)
        XCTAssertEqual(output.outputLanguageAndValueParameters, ["en":"Day","ru":"День"])
    }
    func testSearchLanguage() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        output.outputKeyAndValueResult = "en = Home"
        let found = search.search(key: nil, language: "en")
        guard case Result.success(let value) = found else {
            XCTFail("Ошибка поиска")
            return
        }
        XCTAssertEqual(value, "en = Home")
        XCTAssertEqual(getterData.getDataCallsCount, 1)
        XCTAssertEqual(output.outputKeyAndValueCallsCount, 1)
        XCTAssertEqual(output.outputKeyAndValueParameters, ["home":"Home"])
    }
    func testSearch() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        output.outputAllDataResult = "home\nen:Home\nru:Дом"
        let found = search.search(key: nil, language: nil)
        guard case Result.success(let value) = found else {
            XCTFail("Ошибка поиска")
            return
        }
        XCTAssertEqual(value, "home\nen:Home\nru:Дом")
        XCTAssertEqual(getterData.getDataCallsCount, 1)
        XCTAssertEqual(output.outputAllDataCallsCount, 1)
        XCTAssertEqual(output.outputAllDataParameters, ["home":["en":"Home","ru":"Дом"]])
    }
   
    static var allTests = [
         ("testSearch", testSearch),
         ("testSearchKey", testSearchKey),
         ("testSearchKeyAndLanguage", testSearchKeyAndLanguage),
         ("testSearchLanguage", testSearchLanguage)
    ]
}