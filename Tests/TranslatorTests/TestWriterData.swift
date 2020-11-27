@testable import Translator
import XCTest
class TestWriterData: XCTestCase {
    private var writer : WriterData!
    private var getter: GetData!
    override func setUp() {
        super.setUp()
        writer = WriterData()
        getter = GetData()
    }
   override func tearDown() {
        writer = nil
        super.tearDown()
    }
    func testWritingData() throws {
        let dictionary = ["home":["en":"Home","ru":"Дом"]]
        writer.writingData(data: dictionary)
        if getter.getData() != dictionary {
            XCTFail("Не удалось записать")
        }
        
    }
    static var allTests = [
         ("testWritingData", testWritingData)
    ]
}