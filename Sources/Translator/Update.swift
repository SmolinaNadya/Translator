import Foundation
class Update: UpdateProtocol {
    private let writer: WriterDataProtocol
    private let getterData: GetDataProtocol
    private var words: [String: [String: String]]
    init (getterData: GetDataProtocol, writer: WriterDataProtocol) { 
        self.getterData = getterData
        self.words = getterData.getData()
        self.writer = writer
    }
    func update(newWord: String, key: String, language: String) {
        var dictionary = words[key] ?? [:]
        if dictionary.isEmpty {
            words[key] = [language : newWord]
        }
        else {
            dictionary[language] = newWord
            words[key] = dictionary
        }
        writer.writingData(data: words)
    }
}