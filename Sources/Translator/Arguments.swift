enum Arguments {
    case search(k: String?, l: String?)
    case update(word: String, k: String, l: String)
    case delete(k: String?, l: String?)
}