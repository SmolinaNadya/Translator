@testable import Translator
import XCTest
final class TestDelete: XCTestCase {
    private var delete: Delete!
    private var getterData: GetDataMock!
    private var writer: WriterDataMock!
    private var search: SearchMock!
    override func setUp() {
        super.setUp()
        getterData = GetDataMock()
        writer = WriterDataMock()
        search = SearchMock()
        delete = Delete(getterData: getterData, writer: writer, search: search)
    }
    override func tearDown() {
        delete = nil
        getterData = nil
        writer = nil
        super.tearDown()
    }
    func testDeleteWithAllKeys() throws {
        getterData.getDataResult = ["day":["ru":"День","en":"Day"],"home":["ru":"Дом","pt":"Dia"]]
        search.searchResult = .failure(AppErrors.notFound)
        let result = delete.delete(key: "day", language: "en")
        guard case Result.success(let value) = result else {
            XCTFail("Ошибка удаления")
            return
        }
        XCTAssertEqual(value, "Данные успешно удалены")
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, ["day":["ru":"День"],"home":["ru":"Дом","pt":"Dia"]])
        XCTAssertEqual(getterData.getDataCallsCount, 2)  
    }
    func testDeleteWithKey() throws {
        getterData.getDataResult = ["home":["en":"Home"]]
        search.searchResult = .failure(AppErrors.notFound)
        let result = delete.delete(key: "home", language: nil)
        guard case Result.success(let value) = result else {
            XCTFail("Ошибка удаления")
            return
        }
        XCTAssertEqual(value, "Данные успешно удалены")
        XCTAssertEqual(getterData.getDataCallsCount, 2)
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, [:])
    }
    func testDeleteWithLanguage() throws {
        getterData.getDataResult = ["home":["en":"Home","ru":"Дом"]]
        search.searchResult = .failure(AppErrors.notFound)
        let result = delete.delete(key: nil, language: "en")
       guard case Result.success(let value) = result else {
            XCTFail("Ошибка удаления")
            return
        }
        XCTAssertEqual(value, "Данные успешно удалены")
        XCTAssertEqual(getterData.getDataCallsCount, 2)
        XCTAssertEqual(writer.writingDataCallsCount, 1)
        XCTAssertEqual(writer.writingDataParameters, ["home":["ru":"Дом"]])
    }
    func testDeleteNoArguments() throws {
        let result = delete.delete(key: nil, language: nil)
        guard case Result.failure(let value) = result else {
            XCTFail("Ошибка удаления")
            return
        }
        XCTAssertEqual(value, AppErrors.errorNotArguments)
        XCTAssertEqual(writer.writingDataCallsCount, 0)
    }

    static var allTests = [
         ("testDeleteWithAllKeys", testDeleteWithAllKeys),
         ("testDeleteWithKey", testDeleteWithKey),
         ("testDeleteWithLanguage", testDeleteWithLanguage),
         ("testDeleteNoArguments", testDeleteNoArguments)
    ]
}