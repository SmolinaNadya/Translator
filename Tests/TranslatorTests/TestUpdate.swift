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
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        let result = update.update(newWord: "Домик", key: "home", language: "ru")
        XCTAssertEqual(result, Result.updateSuccess)
        XCTAssertEqual(getterData.getDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, ["home":["en":"Home","ru":"Домик"]])
        //XCTAssertEqual(getterData.getData())
    }
    
    static var allTests = [
        ("testUpdateWithAllKey", testUpdateWithAllKey)
    ]
}