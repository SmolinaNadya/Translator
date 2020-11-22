protocol UpdateProtocol {
    func update(newWord: String, key: String, language: String) -> Result
}