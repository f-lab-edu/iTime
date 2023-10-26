

import Foundation
import LoggedOut
import LoggedOutImpl
import NeedleFoundation
import RIBs

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class LoggedOutDependencyd80ab2fd4f0c552fa83fProvider: LoggedOutDependency {


    init() {

    }
}
/// ^->AppComponent->AppRootComponent->LoggedOutComponent
private func factory19919712107fbe4d3399e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return LoggedOutDependencyd80ab2fd4f0c552fa83fProvider()
}
private class AppRootDependency9fafbf379aae0424b417Provider: AppRootDependency {


    init() {

    }
}
/// ^->AppComponent->AppRootComponent
private func factorya90cb427e52e03443c85e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AppRootDependency9fafbf379aae0424b417Provider()
}

#else
extension LoggedOutComponent: Registration {
    public func registerItems() {

    }
}
extension AppComponent: Registration {
    public func registerItems() {


    }
}
extension AppRootComponent: Registration {
    public func registerItems() {


    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->AppComponent->AppRootComponent->LoggedOutComponent", factory19919712107fbe4d3399e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->AppRootComponent", factorya90cb427e52e03443c85e3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
