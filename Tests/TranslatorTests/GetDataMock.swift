@testable import Translator
class GetDataMock : GetDataProtocol {
    var getDataParameters: ()
    var getDataResult: [String: [String: String]] = [:]
    var getDataCallsCount = 0
    func getData() -> [String: [String: String]] {
       getDataCallsCount += 1
       getDataParameters = ()
       return getDataResult
    }
}