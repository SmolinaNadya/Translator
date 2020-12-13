import Foundation
import ArgumentParser
public func translator() -> Int {
    let container = Container()
    let parser = container.argumentParser
    let arguments = parser.toParse(nil)
    switch arguments {
        case .search(let key, let language):
          let lines = container.search.search(key: key, language: language)
          switch lines {
            case .success(let value):
              container.printer.printingData(data: value)
              return 0
            case .failure(_):
              return 1   
           }
        case .update(let word, let key, let language):
          let answer = container.update.update(newWord: word, key: key, language: language)
          switch answer {
            case .success(let value):
              container.printer.printingData(data: value)
              return 0
            case .failure(_):
              return 2
          }
        case .delete(let key, let language):
          let answer = container.delete.delete(key: key, language: language)
          switch answer {
            case .success(let value):
              container.printer.printingData(data: value)
              return 0
            case .failure(let error):
              switch error {
                case .errorNotArguments:
                  return 3
                case .deleteError:
                  return 4
                default:
                  return 6
             }
          }
        default:
          container.printer.printingData(data: container.help.help())
          return 5
    }  
}

public class Container {
   public init() {

    }
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
    public var search: SearchProtocol {
        return Search(getterData: getData, outputData: outputData)
    }
    public var update: UpdateProtocol {
        return Update(getterData: getData, writer: writer,search: search)
    }
    public var delete: DeleteProtocol {
        return Delete(getterData: getData, writer: writer, search: search)
    }
    var help: HelpProtocol {
        return Help()
    }
    var printer: PrintingDataProtocol {
        return PrintingData()
    }
}