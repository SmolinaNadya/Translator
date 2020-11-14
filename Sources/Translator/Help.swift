class Help: HelpProtocol {
    func help() -> String {
        return Commands.helpMessage()
    }
}