@testable import Translator
import XCTest
class TestUpdate: XCTestCase {
    private var update: Update!
    private var getterData: GetDataMock!
    private var writer: WriterDataMock!
    private var search: SearchMock!
    override func setUp() {
        super.setUp()
        getterData = GetDataMock()
        writer = WriterDataMock()
        search = SearchMock()
        update = Update(getterData: getterData, writer: writer,search: search)
    }
    override func tearDown() {
        update = nil
        getterData = nil
        writer = nil
        search = nil
        super.tearDown()
    }
    func testUpdateWithAllKey() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        let result = update.update(newWord: "Домик", key: "home", language: "ru")
        guard case Result.success(let value) = result else {
            XCTFail("Ошибка обновления")
            return
        }
        XCTAssertEqual(value, "Данные успешно обновлены")
        XCTAssertEqual(getterData.getDataCallsCount, 2)
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, ["home":["en":"Home","ru":"Домик"]])
    }
    
    static var allTests = [
        ("testUpdateWithAllKey", testUpdateWithAllKey)
    ]
}