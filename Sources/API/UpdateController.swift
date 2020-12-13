import Translator
import Vapor
import Fluent

struct UpdateController: RouteCollection {
    let update: UpdateProtocol
    init(update: UpdateProtocol) {
        self.update = update
    }

    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("update")
        todos.get(use: update)
    }

    func update(req: Request) -> EventLoopFuture<String> {
        let parameters = try? req.query.decode(Parameters.self)
        req.logger.info("Parameters: \(parameters?.word ?? "") \(parameters?.key ?? "") \(parameters?.language ?? "")")
        let result = update.update(newWord: parameters?.word ?? "", key: parameters?.key ?? "", language: parameters?.language ?? "").mapError{ $0 as Error }
        return req.eventLoop.future(result: result)
    }
}

private extension UpdateController {
    struct Parameters: Content {
        let word: String
        let key: String
        let language: String
    }
}