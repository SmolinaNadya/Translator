@testable import Translator
import XCTest
class TestArgumentParser: XCTestCase {
    private var argumentParser: ArgumentParser!
    override func setUp() {
        super.setUp()
        argumentParser = ArgumentParser()
    }
    override func tearDown() {
        argumentParser = nil
        super.tearDown()
    }
    func testSearchWithKey() throws {
        let result = argumentParser.toParse(["search", "-k", "home"])
        switch result {
            case .search(let key, let language):
              XCTAssertEqual(key, "home")
              XCTAssertEqual(language, nil)
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testSearchWithLanguage() throws {
        let result = argumentParser.toParse(["search", "-l", "ru"])
        switch result {
            case .search(let key, let language):
              XCTAssertEqual(key, nil)
              XCTAssertEqual(language, "ru")
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testSearchKeyAndLanguage() throws {
        let result = argumentParser.toParse(["search", "-k", "home", "-l", "ru"])
        switch result {
            case .search(let key, let language):
              XCTAssertEqual(key, "home")
              XCTAssertEqual(language, "ru")
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testSearchNotKeyNotLanguage() throws {
        let result = argumentParser.toParse(["search"])
        switch result {
            case .search(let key, let language):
              XCTAssertEqual(key, nil)
              XCTAssertEqual(language, nil)
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testDeleteKeyAndLanguage() throws {
        let result = argumentParser.toParse(["delete", "-k", "day", "-l", "en"])
        switch result {
            case .delete(let key, let language):
              XCTAssertEqual(key, "day")
              XCTAssertEqual(language, "en")
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testDeleteWithKey() throws {
        let result = argumentParser.toParse(["delete", "-k", "hello"])
        switch result {
            case .delete(let key, let language):
              XCTAssertEqual(key, "hello")
              XCTAssertEqual(language, nil)
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testDeleteWithLanguage() throws {
        let result = argumentParser.toParse(["delete", "-l", "pt"])
        switch result {
            case .delete(let key, let language):
              XCTAssertEqual(key, nil)
              XCTAssertEqual(language, "pt")
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testUpdate() throws {
        let result = argumentParser.toParse(["update", "Apple", "-k", "apple", "-l", "en"])
        switch result {
            case .update(let word, let key, let language):
              XCTAssertEqual(word, "Apple")
              XCTAssertEqual(key, "apple")
              XCTAssertEqual(language, "en")
            default:
              XCTFail("Ошибка преобразования аргументов")
        }
    }
    func testNotCorrectCommand() throws {
        if argumentParser.toParse(["go"]) != nil {
        XCTFail("Ошибка преобразования аргументов")
      }
    }
    func testNotCommand() throws {
      if argumentParser.toParse([""]) != nil {
        XCTFail("Ошибка преобразования аргументов")
      }
    }
    func testUpdateNotWord() throws {
      if argumentParser.toParse(["update -k home -l ru"]) != nil {
        XCTFail("Ошибка преобразования аргументов")
      }
    }
    static var allTests = [
        ("testSearchWithKey", testSearchWithKey),
        ("testSearchWithLanguage", testSearchWithLanguage),
        ("testSearchKeyAndLanguage", testSearchKeyAndLanguage),
        ("testSearchNotKeyNotLanguage", testSearchNotKeyNotLanguage),
        ("testDeleteKeyAndLanguage", testDeleteKeyAndLanguage),
        ("testDeleteWithKey", testDeleteWithKey),
        ("testDeleteWithLanguage", testDeleteWithLanguage),
        ("testUpdate", testUpdate),
        ("testNotCorrectCommand", testNotCorrectCommand),
        ("testNotCorrectCommand", testNotCorrectCommand),
        ("testUpdateNotWord", testUpdateNotWord)
    ]
}
