@testable import Translator
import XCTest
class TestSearch: XCTestCase {
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
        let result = search.search(key: "day", language: "pt").result
        XCTAssertEqual(result, Result.searchSuccess)
    }
    func testSearchKey() throws {
        let result = search.search(key: "day", language: nil).result
        XCTAssertEqual(result, Result.searchSuccess)
    }
    func testSearchLanguage() throws {
        let result = search.search(key: nil, language: "pt").result
        XCTAssertEqual(result, Result.searchSuccess)
    }
    func testSearch() throws {
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