@testable import Translator
class OutputDataMock : OutputDataProtocol {
    var outputLanguageAndValueParameters: ([String:String])!
    var outputLanguageAndValueResult = ""
    var outputLanguageAndValueCallsCount = 0

    func outputLanguageAndValue(dictionary: [String:String]) -> String {
        outputLanguageAndValueCallsCount += 1
        outputLanguageAndValueParameters = (dictionary)
        return outputLanguageAndValueResult
    }
    
    var outputKeyAndValueParameters: ([String:String])!
    var outputKeyAndValueResult = ""
    var outputKeyAndValueCallsCount = 0

    func outputKeyAndValue (dictionary: [String:String]) -> String {
        outputKeyAndValueCallsCount += 1
        outputKeyAndValueParameters = (dictionary)
        return outputKeyAndValueResult
    }
    
    var outputAllDataParameters: ([String: [String: String]])!
    var outputAllDataResult = ""
    var outputAllDataCallsCount = 0
    
    func outputAllData (dictionary: [String: [String: String]]) -> String {
        outputAllDataCallsCount += 1
        outputAllDataParameters = (dictionary)
        return outputAllDataResult
    }
}