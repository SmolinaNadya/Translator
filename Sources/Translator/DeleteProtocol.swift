public protocol DeleteProtocol {
    func delete(key: String?, language: String?) -> Result<String, AppErrors>
}