import Foundation
class Update: UpdateProtocol {
    private let writer: WriterDataProtocol
    private let getterData: GetDataProtocol
    private let search: SearchProtocol
    init (getterData: GetDataProtocol, writer: WriterDataProtocol,search: SearchProtocol) { 
        self.getterData = getterData
        self.writer = writer
        self.search = search
    }
    func update(newWord: String, key: String, language: String) -> Result<String, AppErrors> {
        var words = getterData.getData()
        var dictionary = words[key] ?? [:]
        if dictionary.isEmpty {
            words[key] = [language : newWord]
        }
        else {
            dictionary[language] = newWord
            words[key] = dictionary
        }
        writer.writingData(data: words)
        words = getterData.getData()
        let updatingWord = search.search(key: key, language: language)
        switch updatingWord {
            case .success(_):
              return .success("Данные успешно обновлены")
            case .failure(_):
              return .failure(.updateError)
        }
    }
}