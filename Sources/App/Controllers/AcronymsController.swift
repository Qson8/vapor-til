//
//  AcronymsController.swift
//  App
//
//  Created by Qson on 2018/11/9.
//

import Vapor
import Fluent

struct AcronymsController : RouteCollection {
    
    func boot(router: Router) throws {
        
        // route groups
        let acronymsRoutes = router.grouped("api", "acronyms")
        
        /** C 增 */
//        acronymsRoutes.post(use: createHandler)
        acronymsRoutes.post(Acronym.self, use: createHandler)
        
        /** R 查 */
        acronymsRoutes.get(use: getAllHandler)
        acronymsRoutes.get(Acronym.parameter, use: getHandle)
        /** U 改 */
        acronymsRoutes.put(Acronym.parameter, use: updataHandler)
        /** D 删 */
        acronymsRoutes.delete(Acronym.parameter, use: deleteHandler)
    }
    
    // 查询所有
    func getAllHandler(_ req: Request) throws -> Future<[Acronym]> {
        return Acronym.query(on: req).all()
    }
    
    // 增
    func createHandler(_ req: Request, acronym:Acronym) throws -> Future<Acronym> {
        return try req.content.decode(Acronym.self).flatMap(to: Acronym.self) { (acronym) in
            return acronym.save(on: req)
        }
    }
    
    // 查
    func getHandle(_ req: Request) throws -> Future<Acronym> {
        return try req.parameters.next(Acronym.self)
    }
    
    // 改
    func updataHandler(_ req: Request) throws -> Future<Acronym> {
        return try flatMap(to: Acronym.self, req.parameters.next(Acronym.self), req.content.decode(Acronym.self), { (acronym, updatedAcronym) in
            acronym.short = updatedAcronym.short;
            acronym.long = updatedAcronym.long;
            return acronym.save(on: req)
        })
    }
    
    // 删
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Acronym.self).delete(on:req).transform(to: HTTPStatus.noContent)
    }
    
}


