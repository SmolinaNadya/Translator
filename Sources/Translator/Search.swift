import Foundation
class Search: SearchProtocol {
    private let getterData: GetDataProtocol
    private var lines = ""
    private var words: [String: [String: String]]
    init (getterData: GetDataProtocol) {
        self.getterData = getterData
        self.words = getterData.getData()
    }
    func search(key: String?, language: String?) -> String {
        if let newKey: String = key {
            if let newLanguage: String = language {
                lines = translate(key: newKey, language: newLanguage)
            }
            else {
                lines = translate(key: newKey)
            }
        }
        else {
            if let newLanguage: String = language {
                lines = translate(language: newLanguage)
            }
            else {
                lines = translate()
            }
        }
        if lines == "" {
            return "Not found"
        }
        return lines
    }
    private func translate(key: String, language: String) -> String {
         var lines = ""
         for (word, dictionary) in words {
             if key == word {
                 for (existingLanguage, value) in dictionary {
                     if language == existingLanguage {  
                        lines = "\(value)"
                     }
                 }
             }
         }
         return lines
    }
    private func translate(key: String) -> String {
        var lines = ""
        for (word, dictionary) in words {
            if key == word {
                for (language, value) in dictionary {
                    if lines == "" {
                        lines = "\(language):\(value)"
                    }
                    else {
                        lines += "\n\(language):\(value)"
                    }
                }
            }
        }
        return lines
    }
    private func translate(language: String) -> String {
        var lines = ""
        for (word, dictionary) in words {
            for (existingLanguage, value) in dictionary {
                if language == existingLanguage {
                    if lines == "" {
                        lines =  "\(word) = \(value)"
                    }
                    else {
                        lines +=  "\n\(word) = \(value)"
                    }
                }
            }
        }
        return lines
    }         
    private func translate() -> String {
        var lines = ""
        for (word, dictionary) in words {
            print(word)
            for (language, value) in dictionary {
                if lines == "" {
                    lines = "\(language):\(value)"
                }
                else {
                    lines += "\n\(language):\(value)"
                }
            }
        }
        return lines
    }
}
        
          
    