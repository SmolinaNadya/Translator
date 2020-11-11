import Foundation
import ArgumentParser
func main() {
    let container = Container()
    let parser = container.argumentParser
    guard let arguments = parser.toParse() else {
        container.help.help()
        return
    }
    if case .search(let k, let l) = arguments {
        container.search.search(k: k, l: l)
    }
    else if case .update(let word, let k, let l) = arguments {
        container.update.update(newWord: word, k: k, l: l)
    }
    else if case .delete(let k, let l) = arguments {
        container.delete.delete(k: k, l: l)
    }
}
main()
class Container {
    var argumentParser: ArgumentParserProtocol {
        return ArgumentParser()
    }
    var writer: WriterDataProtocol {
        return WriterData()
    }
    var getData: GetDataProtocol {
        return GetData()
    }
    var search: SearchProtocol {
        return Search(getterData: getData)
    }
    var update: UpdateProtocol {
        return Update(getterData: getData, writer: writer)
    }
    var delete: DeleteProtocol {
        return Delete(getterData: getData, writer: writer)
    }
    var help: HelpProtocol {
        return Help()
    }
}