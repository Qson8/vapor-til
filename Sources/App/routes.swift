import Vapor
import FluentSQLite

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // 向路由器注册新类型
    let acronymsController = AcronymsController()
    try router.register(collection: acronymsController)

    /*
    // Example of configuring a controller
    // 1 增加数据
    router.post("api", "acronyms") { (req) -> Future<Acronym> in
        // 2
        return try req.content.decode(Acronym.self).flatMap(to: Acronym.self) { (acronym) in
            // 3
            return acronym.save(on: req)
        }
    }
    
    // 2 查询所有数据
//    router.get("api", "acronyms") { (req) -> Future<[Acronym]> in
//        return Acronym.query(on: req).all()
//    }
    // 查询逻辑封装到控制器
//    router.get("api", "acronyms", use: acronymsController.getAllHandler)
    
    
    // 3.按条件查询
    router.get("api", "acronyms", Acronym.parameter) { (req) -> Future<Acronym> in
        return try req.parameters.next(Acronym.self)
    }
    
    // 4.修改数据 put
    router.put("api", "acronyms", Acronym.parameter) { (req) -> Future<Acronym> in
        return try flatMap(to: Acronym.self, req.parameters.next(Acronym.self), req.content.decode(Acronym.self), { (acronym, updatedAcronym) in
            acronym.short = updatedAcronym.short
            acronym.long = updatedAcronym.long
            
            return acronym.save(on: req)
        })
    }
    
    // 5.删除数据
    router.delete("api", "acronyms", Acronym.parameter) { (req) -> Future<HTTPStatus> in
        let a = try req.parameters.next(Acronym.self).delete(on:req).transform(to: HTTPStatus.noContent)
        return a
    }
    
    // 搜索单个字段
    router.get("api", "acronyms", "search") { (req) -> Future<[Acronym]> in
        guard
            let searchTerm = req.query[String.self,at: "term"]
        else  {
            throw Abort(.badRequest)
        }
        
        // \Acronym.short keyPath
        return Acronym.query(on: req).filter(\Acronym.short == searchTerm).all()
    }
    
     // 搜索多个字段
    router.get("api", "acronyms", "search") { (req) -> Future<[Acronym]> in
        guard
            let searchTerm = req.query[String.self,at: "term"]
            else  {
                throw Abort(.badRequest)
        }
        
        // \Acronym.short keyPath
        return Acronym.query(on: req).group(.or) { (or) in
            or.filter(\Acronym.short == searchTerm)
            or.filter(\Acronym.long == searchTerm)
        }.all()
    }
    
    // 查询第一个
    router.get("api", "acronym", "first") { (req) -> Future<Acronym> in
        let result = Acronym.query(on: req).first().map(to: Acronym.self) {
            acronym in
            
            // 确保acronym有值，无值则报notFound
            guard let acronym = acronym else {
                throw Abort(.notFound)
            }
            return acronym
        }
        
        return result
    }
    // 查询结果排序
    router.get("api", "acronyms", "sorted") {
        req -> Future<[Acronym]> in
        return Acronym.query(on: req).sort(\Acronym.short, ._ascending).all()
    }
    */

}

