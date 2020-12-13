import Foundation
class Search: SearchProtocol {
    private let getterData: GetDataProtocol
    private let outputData: OutputDataProtocol
    private var lines = ""
    init (getterData: GetDataProtocol, outputData: OutputDataProtocol) {
        self.getterData = getterData
        self.outputData = outputData
    }
    func search(key: String?, language: String?) -> Result<String, AppErrors> {
        let words = getterData.getData()
        if let newKey: String = key {
            if let newLanguage: String = language {
                lines = translate(key: newKey, language: newLanguage, words: words)
            }
            else {
                let dictionary = translate(key: newKey, words: words)
                lines = outputData.outputLanguageAndValue(dictionary: dictionary)
            }
        }
        else {
            if let newLanguage: String = language {
                let dictionary = translate(language: newLanguage, words: words)
                lines = outputData.outputKeyAndValue(dictionary: dictionary)
            }
            else {
                let dictionary = translate(words: words)
                lines = outputData.outputAllData(dictionary: dictionary)
            }
        }
        if lines == "" {
            return .failure(.notFound)
        }
        return .success(lines)
    }
    private func translate(key: String, language: String, words: [String: [String: String]]) -> String {
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
   private func translate(key: String, words: [String: [String: String]]) -> [String:String] {
        guard let dictionary = words[key] else {
            return [:]
        }
        return dictionary
    }
    private func translate(language: String, words: [String: [String: String]]) -> [String:String] {
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
    private func translate(words: [String: [String: String]]) -> [String: [String: String]] {
        return words
    }
}
        
          
    