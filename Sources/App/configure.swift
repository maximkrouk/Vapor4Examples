import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory)
    
    app.databases.use(.postgres(
        hostname: DBConfig.default.hostname,
        username: DBConfig.default.username,
        password: DBConfig.default.password,
        database: DBConfig.default.database
    ), as: .psql)

    app.migrations.add(FileItem.Migration())

    // register routes
    try routes(app)
}
