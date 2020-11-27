import Foundation
import ArgumentParser
public func translator() -> Int {
    let container = Container()
    let parser = container.argumentParser
    var result = Result.notFound
    let arguments = parser.toParse(nil)
    switch arguments {
        case .search(let key, let language):
          let lines = container.search.search(key: key, language: language).lines
          result = container.search.search(key: key, language: language).result
          container.printer.printingData(data: lines)
        case .update(let word, let key, let language):
          result = container.update.update(newWord: word, key: key, language: language)
        case .delete(let key, let language):
          result = container.delete.delete(key: key, language: language)
        default:
          container.printer.printingData(data: container.help.help())
          result = Result.errorArgumentParser
    }  
    switch result {
        case .errorArgumentParser:
          return 1
        case .notFound:
          return 2
        case .errorNotArguments:
          return 3
        case .searchSuccess:
          return 0
        case .deleteSuccess:
          return 0
        case .updateSuccess:
          return 0
    }
}

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
     var outputData: OutputDataProtocol {
        return OutputData()
    }
    var search: SearchProtocol {
        return Search(getterData: getData, outputData: outputData)
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
    var printer: PrintingDataProtocol {
        return PrintingData()
    }
}