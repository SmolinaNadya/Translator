protocol OutputDataProtocol {
    func outputLanguageAndValue(dictionary: [String:String]) -> String 
    func outputKeyAndValue(dictionary: [String:String]) -> String 
    func outputAllData (dictionary: [String: [String: String]]) -> String 
}