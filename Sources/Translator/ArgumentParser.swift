import Foundation
import ArgumentParser
class ArgumentParser: ArgumentParserProtocol {
    func toParse() -> Arguments? {
        do {
            let command = try Commands.parseAsRoot()
            switch command {
            case let command as Commands.Search:
              return .search(k: command.k, l: command.l)
            
            case let command as Commands.Update:
              return .update(word: command.word, k: command.k, l: command.l)

            case let command as Commands.Delete:
              return .delete(k: command.k, l: command.l)

            default:
              return nil
            }
        }
        catch {
            return nil
        }
    }
}

struct Commands: ParsableCommand {
    static var configuration = CommandConfiguration (
        subcommands: [Search.self, Update.self, Delete.self]
    )
}

extension Commands {
    struct Search: ParsableCommand {
        @Option(name: .shortAndLong, help: "The word you want to translate")
        var k: String?

        @Option(name: .shortAndLong, help: "Select a language")
        var l: String?
    }
    struct Update: ParsableCommand {
        @Argument(help: "The word you want to add or update in the dictionary")
        var word: String

        @Option(name: .shortAndLong, help: "The word you want to translate")
        var k: String

        @Option(name: .shortAndLong, help: "Select a language")
        var l: String
    }
    struct Delete: ParsableCommand {
        @Option(name: .shortAndLong, help: "The word you want to translate")
        var k: String?

        @Option(name: .shortAndLong, help: "Select a language")
        var l: String?
    }  
}