import Foundation
import ArgumentParser
 guard let path = Bundle.module.path( forResource: "data", ofType: "json")
 else {
     print("Путь не найден")
     exit(0)
 }
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
    @Argument(help: "To search for words" )
    var choice: String
    @Argument(help: "The word you want to add or update in the dictionary")
    var word: String?
    func run() throws {
        if choice == "search" {
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
       else if choice == "update" {
           guard let newWord: String = word else {
               print("Введите значение <word>")
               return
           }
           guard let newK: String = k else {
               print("Введите значение -k")
               return
           }
           guard let newL: String = l else {
               print("Введите значение -l")
               return
           }
           update(newWord: newWord,l: newL,k: newK)
        }
        else if choice == "delete" {
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
        }
    } 
}
Translator.main()
func update(newWord: String, l: String, k: String) {
    var dictionary = words[k] ?? [:]
    if dictionary.isEmpty {
        words[k] = [l : newWord]
    }
    else {
        dictionary[l] = newWord
        words[k] = dictionary
    }
    writingToFile()
}
func writingToFile() {
    let encoderData = try? JSONEncoder().encode(words)
    guard let url = Bundle.module.url(forResource: "data", withExtension: "json")
    else {
        print("Файл не найден")
        return
    }
    try? encoderData?.write(to: url)
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
    writingToFile()
}
func delete(k: String) {
    words[k] = nil
    writingToFile()
}
func delete(l: String) {
    for (word, dictionary) in words {
        var dictionary = dictionary
      dictionary[l] = nil
      words[word] = dictionary
    }
    writingToFile()
}
func translate(k: String, l: String) {
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
func translate(l: String) {
    for (word, dictionary) in words {
        for (language, value) in dictionary {
            if l == language {
                print("\(word) = \(value)") 
                answer = true}
        }
   }
}

func translate(k: String) {
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
