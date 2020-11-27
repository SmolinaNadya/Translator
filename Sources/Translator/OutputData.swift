class OutputData: OutputDataProtocol {
    private var lines = ""
    func outputLanguageAndValue(dictionary: [String:String]) -> String {
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
    func outputKeyAndValue (dictionary: [String:String]) -> String {
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
    func outputAllData (dictionary: [String: [String: String]]) -> String {
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