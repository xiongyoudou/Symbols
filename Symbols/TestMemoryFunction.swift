//
//  TestMemoryFunction.swift
//  Symbols
//
//  Created by xiong有都 on 2024/1/20.
//

import Foundation

func testMemoryFunction() {
    test_getMemory()
    test_unsafeBitCast()

    test_UnsafePointer()
    test_UnsafeBufferPointer()
    test_unsafeRawPointers()
    
    test_withUnsafeBytes()
    test_withUnsafeBufferPointer()
    test_withMemoryRebound()
}

func test_getMemory() {
    var number = 42
    let pointerToNumber = UnsafeMutablePointer<Int>(&number)
    print(type(of: pointerToNumber))
    
    func modifyValue(_ x: inout Int) {
        print(type(of: x))
        x = 42
    }
    var number2 = 10
    modifyValue(&number2)  // Correct usage of '&'
}

// lldb中可以使用该指令转换类型：
// expression -l swift -o -- unsafeBitCast(0x0000600003da12f0, to: Student.self).id

// 注意在转换两种不同的类型时，必须保证两者size相同。当转换Int64和Float时就会报错如下
// Thread 1: Fatal error: Can't unsafeBitCast between types of different sizes
func test_unsafeBitCast() {
    let intValue: Int32 = 42
    let floatValue = unsafeBitCast(intValue, to: Float.self)
    print(floatValue) // 输出可能是一个不正确的浮点数，因为整数和浮点数的内存表示不同

    let newIntValue = unsafeBitCast(floatValue, to: Int32.self)
    print(newIntValue)
}

func test_UnsafePointer() {
    /// 通过allocate来直接创建一个空的unsafepointer
    let count = 2
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    pointer.initialize(repeating: 0, count: count)
    defer {
        pointer.deinitialize(count: count)
        pointer.deallocate()
    }
    
    pointer.pointee = 42
    pointer.advanced(by: 1).pointee = 6
    print(pointer.pointee)
    print(pointer.advanced(by: 1).pointee)
    
    let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        print("value \(index): \(value)")
    }
    
    /// 通过数组创建一个非empty的unsafepointer
    let array: [Int] = [1, 2, 3, 4, 5]

    // 使用UnsafePointer获取数组的起始地址
    let pointer2 = UnsafePointer(array)

    // 通过指针访问数组中的元素
    for i in 0..<array.count {
        let element = pointer2.advanced(by: i).pointee
        print("Element at index \(i): \(element)")
    }

    // 也可以直接使用指针的下标操作
    for i in 0..<array.count {
        let element = pointer2[i]
        print("Element at index \(i): \(element)")
    }
}

func test_UnsafeBufferPointer() {
    // 创建一个包含整数的原始内存缓冲区
    let array: [Int] = [1, 2, 3, 4, 5]
    let bufferPointer = UnsafeBufferPointer(start: array, count: array.count)

    // 使用 UnsafeBufferPointer 迭代访问缓冲区中的元素
    for element in bufferPointer {
        print(element)
    }

    // 或者通过索引访问缓冲区中的元素
    for i in 0..<bufferPointer.count {
        print(bufferPointer[i])
    }

    // 使用指针进行更底层的操作
    let pointer1 = bufferPointer.baseAddress
    print("First element using pointer:", pointer1?.pointee)
    
    let pointer2 = bufferPointer.baseAddress!.advanced(by: 1)
    print("Second element using pointer:", pointer2.pointee)
}

func test_unsafeRawPointers() {
    // 1
    let count = 2
    let stride = MemoryLayout<Int>.stride
    let alignment = MemoryLayout<Int>.alignment
    let byteCount = stride * count
    
    // 2
    do {
        print("Raw pointers")
        
        // 3
        let pointer = UnsafeMutableRawPointer.allocate(
            byteCount: byteCount,
            alignment: alignment)
        
        // 4
        defer {
            pointer.deallocate()
        }
        
        // 5
        pointer.storeBytes(of: 42, as: Int.self)
        pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
        let value1 = pointer.load(as: Int.self)
        let value2 = pointer.advanced(by: stride).load(as: Int.self)
        print(value1,value2)
        
        // 6
        let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
        for (index, byte) in bufferPointer.enumerated() {
            print("byte \(index): \(byte)")
        }
    }

}

func test_withUnsafeBytes() {
    struct SampleStruct {
        let number: Int
        let flag: Bool
    }
    
    print("Getting the bytes of an instance")
    var sampleStruct = SampleStruct(number: 25, flag: true)
    withUnsafeBytes(of: &sampleStruct) { bytes in
        for byte in bytes {
            print(byte)
        }
    }
    print("===================================")
}

func test_withUnsafeBufferPointer() {
    let numbers = [1, 2, 3, 4, 5]
    let sum = numbers.withUnsafeBufferPointer { buffer -> Int in
        // buffer: UnsafeBufferPointer
        
        var result = 0
        for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
            result += buffer[i]
        }
        return result
    }
    print(sum)
    // 'sum' == 9
}

func test_withMemoryRebound() {
    // 创建一个指向整数的指针
    var intValue = 42
    let intPointer = UnsafeMutablePointer<Int>(&intValue)

    // 使用withMemoryRebound将整数指针重新绑定为浮点数指针
    let result = intPointer.withMemoryRebound(to: Float.self, capacity: 1) { floatPointer -> Float in
        // 在此闭包中，floatPointer 的类型被重新绑定为 Float
        // 可以在这里访问重新绑定后的内存
        floatPointer.pointee = 3.14
        return floatPointer.pointee
    }

    // 打印结果
    print("Result: \(result)")
}


