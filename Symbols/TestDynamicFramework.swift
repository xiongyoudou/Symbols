//
//  TestDynamicFramework.swift
//  Symbols
//
//  Created by xiong有都 on 2024/1/20.
//

import Foundation
import DynamicFramework

func testDynamicFramework() {
    let info = getDataFromDynamic()
    print(info)
}

func getDataFromDynamic() -> String {
    let dynamicProvider = DataProviderFromDynamic(age: 12, name: "lilggggssafdasdfqwery")
    let info = dynamicProvider.provideData()
    return info
}
