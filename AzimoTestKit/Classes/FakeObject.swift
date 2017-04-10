//
//  FakeObject.swift
//  SendMoney
//
//  Created by Mateusz Kuźnik on 22/12/2016.
//  Copyright © 2016 Azimo Ltd. All rights reserved.
//

import Foundation

public enum MaxInvocationResponseCount {
    case infinity
    case max(count: UInt)
}

public struct FakeInvocation<MethodType: Equatable>: Equatable {
    public let method: MethodType
    public let parameters: [String: Any?]

    public init(method: MethodType, parameters: [String: Any?] = [:]) {
        self.method = method
        self.parameters = parameters
    }

    public static func ==(lhs: FakeInvocation, rhs: FakeInvocation) -> Bool {
        return lhs.method == rhs.method
    }
}

public class FakeInvocationResponse<MethodType: Equatable, ResponseType> {
    public let method: MethodType
    public let response: ResponseType?
    public let maxResponseInvocationsCount: MaxInvocationResponseCount
    public var responseInvocationsCount: UInt
    
    public init(method: MethodType,
                response: ResponseType?,
                maxResponseInvocationsCount: MaxInvocationResponseCount = .infinity,
                responseInvocationsCount: UInt = 0) {
        self.method = method
        self.response = response
        self.maxResponseInvocationsCount = maxResponseInvocationsCount
        self.responseInvocationsCount = responseInvocationsCount
    }
}

public protocol FakeObject {
    associatedtype MethodType: Equatable

    var invocations: [FakeInvocation<MethodType>] {get set}
    var invocationsToReturn: [FakeInvocationResponse<MethodType, Any?>] {get set}
}

extension FakeObject {
    public func verify(_ invocation: FakeInvocation<MethodType>) -> Bool {
        return invocations(for: invocation).count == 1
    }

    public func invocations(for invocation: FakeInvocation<MethodType>) -> [FakeInvocation<MethodType>] {
        return invocations.filter { $0 == invocation }
    }

    public mutating func mockInvocationRespons(_ invocationResponse: FakeInvocationResponse<MethodType, Any?>) {
        invocationsToReturn.append(invocationResponse)
    }

    public func createInvocation(_ invocation: MethodType, parameters: [String: Any] = [:]) -> FakeInvocation<MethodType> {
        return FakeInvocation(method: invocation, parameters: parameters)
    }

    public func responseValue<T>(forInvocation invocation: FakeInvocation<MethodType>, defaultValue: T) -> T {
        let invocationToReturnOptional = invocationsToReturn.filter { $0.method == invocation.method }.first
        
        guard let invocationToReturn = invocationToReturnOptional else {
            return defaultValue
        }

        switch invocationToReturn.maxResponseInvocationsCount {
        case .infinity:
            break
        case let .max(count):
            let performedInvocations = invocationToReturn.responseInvocationsCount
            if count <= performedInvocations {
                return defaultValue
            }
        }
        
        invocationToReturn.responseInvocationsCount += 1
        return invocationToReturn.response as! T
    }

    public func responseValue<T>(forInvocation invocation: FakeInvocation<MethodType>, defaultValue: T?) -> T? {
        let invocationToReturnOptional = invocationsToReturn.filter { $0.method == invocation.method }.first

        guard let invocationToReturn = invocationToReturnOptional else {
            return defaultValue
        }
        switch invocationToReturn.maxResponseInvocationsCount {
        case .infinity:
            break
        case let .max(count):
            let performedInvocations = invocationToReturn.responseInvocationsCount
            if count <= performedInvocations {
                return defaultValue
            }
        }
        invocationToReturn.responseInvocationsCount += 1
        guard let t = invocationToReturn.response as? T? else { return nil }
        return t
    }

}