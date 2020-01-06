import Fluent
import Vapor

func routes(_ app: Application) throws {
    try FileItem.routes(app)
    
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
