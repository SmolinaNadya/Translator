import Foundation
class Update: UpdateProtocol {
    private let writer: WriterDataProtocol
    private let getterData: GetDataProtocol
    init (getterData: GetDataProtocol, writer: WriterDataProtocol) { 
        self.getterData = getterData
        self.writer = writer
    }
    func update(newWord: String, key: String, language: String) -> Result {
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
        return .updateSuccess
    }
}