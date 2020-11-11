import Foundation
class Delete: DeleteProtocol {
    private let writer: WriterDataProtocol
    private let getterData: GetDataProtocol
    var words: [String: [String: String]]
    init (getterData: GetDataProtocol, writer: WriterDataProtocol) { 
        self.getterData = getterData
        self.words = getterData.getData()
        self.writer = writer
    }
    func delete(k: String?, l: String?) {
        if let newK: String = k {
              if let newL: String = l {
                delete(k: newK, l: newL)
              }
              else {
                  delete(k: newK)
              }
            }
              else {
                  if let newL: String = l {
                    delete(l: newL)
                } 
              }
              writer.writingData(data: words)
    }
    func delete(k: String, l: String) {
        var dictionary = words[k] ?? [:]
        if dictionary.isEmpty {
            return
            }
        else {
            dictionary[l] = nil
            words[k] = dictionary
        }
    }
    func delete(k: String) {
         words[k] = nil
    }
    func delete(l: String) {
        for (word, dictionary) in words {
            var dictionary = dictionary
            dictionary[l] = nil
            words[word] = dictionary
            }
    }
}