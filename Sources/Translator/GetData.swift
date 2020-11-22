import Foundation
public class GetData: GetDataProtocol {
    public func getData() -> [String: [String: String]] {
        guard let path = Bundle.module.path( forResource: "data", ofType: "json")
        else {
            print("Путь не найден")
            return [:]
        }
        guard let jsonData = FileManager.default.contents(atPath: path) else {
            print("Указанный файл не найден")
            return [:]
        }
        var words: [String: [String: String]]
        words = (try? JSONDecoder().decode([String: [String: String]].self, from: jsonData)) ?? [:]
        return words
    }
}

 
