import Foundation
class Update: UpdateProtocol {
    private let writer: WriterDataProtocol
    private let getterData: GetDataProtocol
    var words: [String: [String: String]]
    init (getterData: GetDataProtocol, writer: WriterDataProtocol) { 
        self.getterData = getterData
        self.words = getterData.getData()
        self.writer = writer
    }
    func update(newWord: String, k: String, l: String) {
        var dictionary = words[k] ?? [:]
        if dictionary.isEmpty {
            words[k] = [l : newWord]
        }
        else {
            dictionary[l] = newWord
            words[k] = dictionary
        }
        writer.writingData(data: words)
    }
}