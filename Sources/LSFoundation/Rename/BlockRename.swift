//
//  BlockRename.swift
//  SupportCode
//
//  Created by Алексей Филиппов on 27.12.2020.
//

// Apple
import Foundation

public typealias VoidBlock = () -> Void
public typealias BoolBlock = (Bool) -> Void
public typealias IntBlock = (Int) -> Void
public typealias DoubleBlock = (Double) -> Void
public typealias StringBlock = (String) -> Void
public typealias DataBlock = (Data) -> Void
public typealias ResultBlock<T> = (Result<T, Error>) -> Void
public typealias ResultErrorBlock<T, E: Error> = (Result<T, E>) -> Void
