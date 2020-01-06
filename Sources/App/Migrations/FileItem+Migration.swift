import Fluent

extension FileItem {
    
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(FileItem.schema)
                .field("id", .int, .identifier(auto: true))
                .field("name", .string, .required)
                .field("data", .data, .required)
                .field("description", .string, .required)
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(FileItem.schema).delete()
        }
    }

}
