protocol SearchProtocol {
    func search(key: String?, language: String?) -> (result: Result, lines: String)
}