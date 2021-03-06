import FluentSQLite
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentSQLiteProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)
//    let sqlite = try SQLiteDatabase(storage: .file(path: "/Users/qson/Desktop/db.sqlite"))
//    let sqlite = try SQLiteDatabase(storage: .file(path: "TILApp/Public/db.sqlite"))
    
    print(sqlite.storage)

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Acronym.self, database: .sqlite)
    services.register(migrations)
    
    /// 配置ip端口
//    services.register(NIOServerConfig.default(hostname: "127.0.0.1", port: 8080))
    services.register(NIOServerConfig.default(hostname: "0.0.0.0", port: 8080))
    // 访问 172.27.0.16:8080

}
