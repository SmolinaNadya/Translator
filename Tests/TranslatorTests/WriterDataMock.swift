@testable import Translator
class WriterDataMock : WriterDataProtocol {
    var writingDataParameters: ([String: [String: String]])!
    var writingDataCallsCount = 0
    func writingData(data: [String: [String: String]]) {
       writingDataCallsCount += 1
       writingDataParameters = data
    }
}