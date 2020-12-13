import Foundation
import Translator
let result = translator()
switch result {
    case 0:
      exit(Int32(result))
    case 1:
      print("Не удалось найти")
    case 2:
      print("Не удалось обновить")
    case 3:
      print("Ошибка в количестве аргументов")
    case 4:
      print("Не удалось удалить")
    case 5:
      print("Не правильная команда")
    default:
      print("Неизвестная ошибка")
}
exit(Int32(result))



