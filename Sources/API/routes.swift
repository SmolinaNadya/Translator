import Fluent
import Vapor
import Translator
import Foundation

public func routes(_ app: Application) throws {
    let container = Container()
    let search = container.search
    let update = container.update
    let delete = container.delete

    app.get() { req in
        return "Приветствую Вас!"
    }
    try app.register(collection: SearchController(search: search))
    try app.register(collection: UpdateController(update: update))
    try app.register(collection: DeleteController(delete: delete))
}