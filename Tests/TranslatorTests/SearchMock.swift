import Foundation
@testable import Translator
class SearchMock: SearchProtocol {
	var searchParameters: (key: String?, language: String?)!
    var searchCallsCount = 0
    var searchResult: Result<String, AppErrors> = .success("")
    func search(key: String?, language: String?) -> Result<String, AppErrors> {
        searchCallsCount += 1
        searchParameters = (key, language)
        return searchResult
    }
}