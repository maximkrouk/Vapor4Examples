struct DBConfig {
    var hostname: String
    var username: String
    var password: String = ""
    var database: String
    
    static var `default` = DBConfig(
        hostname: "localhost",
        username: "admin",
        password: "",
        database: "OpenFAQ")
}
