public class OutputData: OutputDataProtocol {
    private var lines = ""
    public func outputLanguageAndValue(dictionary: [String:String]) -> String {
        for (language, value) in dictionary {
            if lines == "" {
                lines = "\(language):\(value)"
            }
            else {
                lines += "\n\(language):\(value)"
            }     
        }
        return lines
    }
    public func outputKeyAndValue (dictionary: [String:String]) -> String {
        for (key, value) in dictionary {
            if lines == "" {
                lines = "\(key) = \(value)"
            }
            else {
                lines += "\n\(key) = \(value)"
            }
        }
        return lines
    }
    public func outputAllData (dictionary: [String: [String: String]]) -> String {
        for (word, dictionaryLanguageAndValue) in dictionary {
            if lines == "" {
                lines = word
            }
            else {
                lines += "\n\(word)"
            }
            for (language, value) in dictionaryLanguageAndValue {
                    lines += "\n\(language):\(value)"
                }
        }
        return lines
    }
}