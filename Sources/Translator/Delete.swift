import Foundation
class Delete: DeleteProtocol {
    private let writer: WriterDataProtocol
    private let getterData: GetDataProtocol
    private let search: SearchProtocol
    init (getterData: GetDataProtocol, writer: WriterDataProtocol, search: SearchProtocol) { 
        self.getterData = getterData
        self.writer = writer
        self.search = search
    }
    func delete(key: String?, language: String?) -> Result<String, AppErrors> {
        var words = getterData.getData()
        if let newKey: String = key {
            if let newLanguage: String = language {
                words = delete(key: newKey, language: newLanguage, words: words)
            }
            else {
                words = delete(key: newKey, words: words)
            }
        }
        else {
            if let newLanguage: String = language {
               words = delete(language: newLanguage, words: words)
            }
            else {
                return .failure(.errorNotArguments)
            }
        }
        writer.writingData(data: words) 
        words = getterData.getData()
        let deletingWord = search.search(key: key, language: language)
        switch deletingWord {
            case .success(_):
              return .failure(.deleteError)
            case .failure(_):
              return .success("Данные успешно удалены")
        }
    }
    private func delete(key: String, language: String, words: [String: [String: String]]) -> [String: [String: String]] {
        var words = words
        guard var dictionary = words[key] else {
            return words
        } 
        dictionary[language] = nil
        words[key] = dictionary
        return words
    }
    private func delete(key: String, words: [String: [String: String]]) -> [String: [String: String]] {
        var words = words
        words[key] = nil
        return words
    }
    private func delete(language: String,  words: [String: [String: String]]) -> [String: [String: String]] {
        var words = words
        for (word, dictionary) in words {
            var dictionary = dictionary
            dictionary[language] = nil
            words[word] = dictionary
        }
        return words
    }
}