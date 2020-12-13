import Foundation
import Fluent
import FluentSQLiteDriver

struct CreateDictionary: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("dictionary")
            .id()
            .field("word", .string)
            .field("language", .string)
            .field("translation", .string)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("dictionary").delete()
    }
}