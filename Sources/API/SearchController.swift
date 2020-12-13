import Fluent
import Translator
import Vapor
import Foundation

struct SearchController: RouteCollection {
    let search: SearchProtocol
    init (search: SearchProtocol) {
        self.search = search
    }

    func boot(routes: RoutesBuilder) throws {
        let app = routes.grouped("search")
        app.get(use: search)
    }
    
    func search (req: Request) throws -> EventLoopFuture<String> {
        let parameters = try? req.query.decode(Parameters.self)
        req.logger.info("Parameters: \(parameters?.key ?? "") \(parameters?.language ?? "")")
        let result = search.search(key: parameters?.key, language: parameters?.language).mapError{ $0 as Error }
        return req.eventLoop.future(result: result)
    }
}
private extension SearchController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
}