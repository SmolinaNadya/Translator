import Foundation
import ArgumentParser
let path = "Sources/Translator/data.json"
guard let jsonData = FileManager.default.contents(atPath: path) else {
     print("Указанный файл не найден")
     exit(0)
}
var words: [String: [String: String]]
var answer = false
words = try JSONDecoder().decode([String: [String: String]].self, from: jsonData)

struct Translator: ParsableCommand {
    @Option(name: .shortAndLong, help: "The word you want to translate")
    var k: String?
    @Option(name: .shortAndLong, help: "Select a language")
    var l: String?
    func run() throws {
        if let newK:String = k {
            if let newL:String = l {
                Translate(k:newK,l:newL)
            }
            else {
                Translate(k:newK)
            }
        }
        else {
            if let newL:String = l {
                Translate(l:newL)
            }
            else {
                Translate()
            }
        }
        if answer == false {
            print("Not found")
        }
    }
}
Translator.main()
func Translate(k:String,l:String) {
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
func Translate(l:String) {
    for (word, dictionary) in words {
        for (language, value) in dictionary {
            if l == language {
                print("\(word) = \(value)") 
                answer = true}
        }
   }
}

func Translate(k:String) {
   for (word, dictionary) in words {
    if k == word {
        for (language, value) in dictionary {
                print("\(language):\(value)")
                answer = true
           }
        }
   }
}
func Translate() {
    for (word, dictionary) in words {
      print(word)
        for (language, value) in dictionary {
          print("\(language):\(value)")
          answer = true
        }
    }
}
