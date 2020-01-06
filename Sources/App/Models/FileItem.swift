import Fluent
import Vapor

final class FileItem: Model, Content {
    static let schema = "files"
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "data")
    var data: Data
    
    @Field(key: "description")
    var description: String
    
    init() { }

    init(id: Int? = nil, file: File, description: String = "") {
        var file = file
        self.id = id
        self.name = file.filename
        self.data = file.data.readData(length: file.data.readableBytes) ?? Data()
        self.description = description
    }
    
    struct Upload: Content {
        var document: File
    }
    
    struct Info: Content {
        var id: Int?
        var name: String
        var description: String
    }
    
    var info: Info {
        .init(id: id, name: name, description: description)
    }
}
