//
//  DataProviderFromStatic.swift
//  StaticFramework
//
//  Created by xiong有都 on 2023/8/4.
//

import Foundation

public class DataProviderFromStatic {
    
    var age: Int
    var name: String
    
    public init(age:Int, name: String) {
        self.age = age
        self.name = name
    }
    
    public func provideData() -> String {
        let informationData: String
        informationData = "\(name)'s age is \(age) years old"
        return informationData
    }
}
