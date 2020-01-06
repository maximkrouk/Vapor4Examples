import Fluent
import Vapor

extension FileItem {
    
    static func routes(_ app: Application) throws {
        let group = app.grouped("files")
        let controller = Controller()
        group.get(use: controller.index)
        group.get(":file", use: controller.find)
        group.post(use: controller.create)
        group.delete(":file", use: controller.delete)
    }
    
    struct Controller {
        
        func find(req: Request) throws -> EventLoopFuture<FileItem> {
            let fileIdString = req.parameters.get("file") ?? ""
            guard let file = Int(fileIdString) else {
                return req.eventLoop.makeFailedFuture(Abort(.badGateway))
            }
            return FileItem.find(file, on: req.db).unwrap(or: Abort(.notFound))
        }
        
        func index(req: Request) throws -> EventLoopFuture<[FileItem.Info]> {
            return FileItem.query(on: req.db).all().mapEach { $0.info }
        }

        func create(req: Request) throws -> EventLoopFuture<HTTPResponseStatus> {
            let upload = try req.content.decode(FileItem.Upload.self)
            let item = FileItem(file: upload.document)
            return item.save(on: req.db).map { .ok }
        }

        func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
            return try find(req: req)
                .flatMap { $0.delete(on: req.db) }
                .transform(to: .ok)
        }
    }
    
}
