import Translator
import Vapor
import Foundation
import API

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer {app.shutdown()}
try configure(app)
try app.run()