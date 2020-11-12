import Foundation
import ArgumentParser
let container = Container()
var words = container.getData.getData()
func main() {
    let container = Container()
    let parser = container.argumentParser
    guard let arguments = parser.toParse() else {
        container.printer.printingData(data: container.help.help())
        return
    }
    switch arguments {
        case .search(let key, let language):
          let lines = container.search.search(key: key, language: language)
          container.printer.printingData(data: lines)
        case .update(let word, let key, let language):
          container.update.update(newWord: word, key: key, language: language)
        case .delete(let key, let language):
          container.delete.delete(key: key, language: language)
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