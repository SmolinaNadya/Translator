import Foundation
import Vapor
import Fluent

final class Dictionary: Model, Content {
    static let schema = "dictionary"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "word")
    var word: String

    @Field(key: "language")
    var language: String
    
    @Field(key: "translation")
    var translation: String

    init() { }

    init(id: UUID? = nil, word: String, language: String, translation: String) {
        self.id = id
        self.word = word
        self.language = language
        self.translation = translation
    }
}