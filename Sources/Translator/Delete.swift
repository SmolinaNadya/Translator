import Foundation
class Delete: DeleteProtocol {
    private let writer: WriterDataProtocol
    private let getterData: GetDataProtocol
    private var words: [String: [String: String]] = [:]
    init (getterData: GetDataProtocol, writer: WriterDataProtocol) { 
        self.getterData = getterData
        self.writer = writer
    }
    func delete(key: String?, language: String?) -> Result {
        words = getterData.getData()
        if let newKey: String = key {
            if let newLanguage: String = language {
                delete(key: newKey, language: newLanguage)
            }
            else {
                delete(key: newKey)
            }
        }
        else {
            if let newLanguage: String = language {
                delete(language: newLanguage)
            }
            else {
                return .errorNotArguments
            }
        }
        writer.writingData(data: words) 
        return .deleteSuccess 
    }
    private func delete(key: String, language: String) {
        guard var dictionary = words[key] else {
            return
        } 
        dictionary[language] = nil
        words[key] = dictionary
    }
    private func delete(key: String) {
        words[key] = nil
    }
    private func delete(language: String) {
        for (word, dictionary) in words {
            var dictionary = dictionary
            dictionary[language] = nil
            words[word] = dictionary
        }
    }
}