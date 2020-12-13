public protocol SearchProtocol {
    func search(key: String?, language: String?) -> Result<String, AppErrors> 
}