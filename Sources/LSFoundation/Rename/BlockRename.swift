public typealias VoidBlock = () -> Void
public typealias BoolBlock = (Bool) -> Void
public typealias IntBlock = (Int) -> Void
public typealias DoubleBlock = (Double) -> Void
public typealias StringBlock = (String) -> Void
public typealias DataBlock = (Data) -> Void
public typealias ResultBlock<T> = (Result<T, Error>) -> Void
public typealias ResultErrorBlock<T, E: Error> = (Result<T, E>) -> Void

public typealias SendableVoidBlock = @Sendable () -> Void
public typealias SendableBoolBlock = @Sendable (Bool) -> Void
public typealias SendableIntBlock = @Sendable (Int) -> Void
public typealias SendableDoubleBlock = @Sendable (Double) -> Void
public typealias SendableStringBlock = @Sendable (String) -> Void
public typealias SendableDataBlock = @Sendable (Data) -> Void
public typealias SendableResultBlock<T> = @Sendable (Result<T, Error>) -> Void
public typealias SendableResultErrorBlock<T, E: Error> = @Sendable (Result<T, E>) -> Void

public typealias MainActorVoidBlock = @MainActor () -> Void
public typealias MainActorBoolBlock = @MainActor (Bool) -> Void
public typealias MainActorIntBlock = @MainActor (Int) -> Void
public typealias MainActorDoubleBlock = @MainActor (Double) -> Void
public typealias MainActorStringBlock = @MainActor (String) -> Void
public typealias MainActorDataBlock = @MainActor (Data) -> Void
public typealias MainActorResultBlock<T> = @MainActor (Result<T, Error>) -> Void
public typealias MainActorResultErrorBlock<T, E: Error> = @MainActor (Result<T, E>) -> Void
