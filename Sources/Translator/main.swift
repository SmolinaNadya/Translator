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
                translate(k:newK,l:newL)
            }
            else {
                translate(k:newK)
            }
        }
        else {
            if let newL:String = l {
                translate(l:newL)
            }
            else {
                translate()
            }
        }
        if answer == false {
            print("Not found")
        }
    }
}
Translator.main()
func translate(k:String,l:String) {
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
func translate(l:String) {
    for (word, dictionary) in words {
        for (language, value) in dictionary {
            if l == language {
                print("\(word) = \(value)") 
                answer = true}
        }
   }
}

func translate(k:String) {
   for (word, dictionary) in words {
    if k == word {
        for (language, value) in dictionary {
                print("\(language):\(value)")
                answer = true
           }
        }
   }
}
func translate() {
    for (word, dictionary) in words {
      print(word)
        for (language, value) in dictionary {
          print("\(language):\(value)")
          answer = true
        }
    }
}
