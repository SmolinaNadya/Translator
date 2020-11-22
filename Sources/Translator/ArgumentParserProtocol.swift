import Foundation
protocol ArgumentParserProtocol {
    func toParse(_ arguments: [String]?) -> Arguments?
}