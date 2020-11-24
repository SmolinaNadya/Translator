@testable import Translator
import XCTest
class TestSearch: XCTestCase {
    private var search: Search!
    private var getterData: GetDataMock!
    private var output: OutputDataMock!
    private var words: [String: [String: String]]!
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
        let result = search.search(key: "home", language: "ru").result
        XCTAssertEqual(result, Result.searchSuccess)
    }
    func testSearchKey() throws {
        getterData.getDataResult = ["day":["en":"Day","ru":"День"]]
        output.outputLanguageAndValueResult = "en:Day\nru:День"
        let result = search.search(key: "day", language: nil).result
        XCTAssertEqual(result, Result.searchSuccess)
    }
    func testSearchLanguage() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        output.outputKeyAndValueResult = "en = Home"
        let result = search.search(key: nil, language: "en").result
        XCTAssertEqual(result, Result.searchSuccess)
    }
    func testSearch() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        output.outputAllDataResult = "home\nen:Home\nru:Дом"
        let result = search.search(key: nil, language: nil).result
        XCTAssertEqual(result, Result.searchSuccess)
    }
   
    static var allTests = [
         ("testSearch", testSearch),
         ("testSearchKey", testSearchKey),
         ("testSearchKeyAndLanguage", testSearchKeyAndLanguage),
         ("testSearchLanguage", testSearchLanguage)
    ]
}