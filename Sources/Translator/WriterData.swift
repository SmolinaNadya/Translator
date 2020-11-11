import Foundation
class WriterData: WriterDataProtocol {
    func writingData(data: [String: [String: String]]) {
        let encoderData = try? JSONEncoder().encode(data)
        guard let url = Bundle.module.url(forResource: "data", withExtension: "json")
        else {
            print("Файл не найден")
            return
        }
         try? encoderData?.write(to: url)
    }
}