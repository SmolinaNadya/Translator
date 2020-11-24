import Foundation
class Search: SearchProtocol {
    private let getterData: GetDataProtocol
    private let outputData: OutputDataProtocol
    private var lines = ""
    var words: [String: [String: String]] = [:]
    init (getterData: GetDataProtocol, outputData: OutputDataProtocol) {
        self.getterData = getterData
        self.outputData = outputData
    }
    func search(key: String?, language: String?) -> (result: Result, lines: String) {
        words = getterData.getData()
        if let newKey: String = key {
            if let newLanguage: String = language {
                lines = translate(key: newKey, language: newLanguage)
            }
            else {
                let dictionary = translate(key: newKey)
                lines = outputData.outputLanguageAndValue(dictionary: dictionary)
            }
        }
        else {
            if let newLanguage: String = language {
                let dictionary = translate(language: newLanguage)
                lines = outputData.outputKeyAndValue(dictionary: dictionary)
            }
            else {
                let dictionary = translate()
                lines = outputData.outputAllData(dictionary: dictionary)
            }
        }
        if lines == "" {
            return (.notSuccess, "Not found")
        }
        return (.searchSuccess, lines)
    }
    private func translate(key: String, language: String) -> String {
         for (word, dictionary) in words {
             if key == word {
                 for (existingLanguage, value) in dictionary {
                     if language == existingLanguage {  
                        return value
                     }
                 }
             }
         }
         return ""
    }
   private func translate(key: String) -> [String:String] {
        guard let dictionary = words[key] else {
            return [:]
        }
        return dictionary
    }
    private func translate(language: String) -> [String:String] {
        var dictionaryWordAndValue: [String: String]  = [:]
        for (word, dictionary) in words {
            for (existingLanguage, value) in dictionary {
                if language == existingLanguage {
                    dictionaryWordAndValue[word] = value
                }
            }
        }
        return dictionaryWordAndValue
    }         
    private func translate() -> [String: [String: String]] {
        return words
    }
}
        
          
    