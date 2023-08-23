//
//  DataProviderFromDynamic.swift
//  DynamicFramework
//
//  Created by xiong有都 on 2023/8/4.
//

import Foundation

public class DataProviderFromDynamic {
    
    var age: Int
    public var name: String
    
    public init(age:Int, name: String) {
        self.age = age
        self.name = name
    }
    
    public func provideData() -> String {
        let informationData: String
        name = getFullName()
        informationData = "\(name)'s age is \(age) years old"
        return informationData
    }
    
    private func getFullName() -> String {
        return "\(name) XIONG"
    }
}
