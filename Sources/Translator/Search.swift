import Foundation
class Search: SearchProtocol {
    private let getterData: GetDataProtocol
    var answer = false
    var words: [String: [String: String]]
    init (getterData: GetDataProtocol) {
        self.getterData = getterData
        self.words = getterData.getData()
    }
    func search(k: String?, l: String?) {
        if let newK: String = k {
              if let newL: String = l {
                translate(k: newK, l: newL)
              }
              else {
                translate(k: newK)
              }
        }
        else {
            if let newL: String = l {
                translate(l: newL)
            }
            else {
                translate()
            }
        }
        if answer == false {
            print("Not found")
        }
    }
    private func translate(k: String, l: String) {
         for (word, dictionary) in words {
             if k == word {
                 for (language, value) in dictionary {
                     if l == language {
                         print(value) 
                         answer = true
                     }
                 }
             }
         }
    }
    private func translate(k: String) {
        for (word, dictionary) in words {
            if k == word {
                for (language, value) in dictionary {
                    print("\(language):\(value)")
                     answer = true
                }
            }
        }
    }
    private func translate(l: String) {
        for (word, dictionary) in words {
            for (language, value) in dictionary {
                if l == language {
                    print("\(word) = \(value)") 
                     answer = true
                }
            }
        }
    }         
    private func translate() {
        for (word, dictionary) in words {
            print(word)
            for (language, value) in dictionary {
                print("\(language):\(value)")
                answer = true
            }
        }
    }
}
        
          
    