import Foundation
public enum Result : Error {
    case searchSuccess
    case updateSuccess
    case deleteSuccess
    case notSuccess
    case deleteError
    case updateError
    case errorNotArguments
    case errorArgumentParser
}