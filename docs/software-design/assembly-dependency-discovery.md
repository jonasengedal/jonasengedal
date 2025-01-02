# Assembly IoC Dependency Discovery

Automated assembly dependency discovery simplifies the process of configuring dependency injection by scanning assemblies for classes and interfaces, identifying their relationships through custom attributes. These attributes define the lifecycle of the dependencies (e.g., Singleton, Scoped, Transient) and specify special behaviors, such as overriding implementations during testing. The discovery process dynamically registers these dependencies into the application's IoC (Inversion of Control) container.

Most of this page is created by ChatGPT.

## Implementation

### Attributes

First, define the attributes for lifecycle and testing behavior:

```csharp
using System;

public enum Lifecycle
{
    Singleton,
    Scoped,
    Transient
}

[AttributeUsage(AttributeTargets.Class, Inherited = false, AllowMultiple = false)]
public sealed class DependencyAttribute : Attribute
{
    public Lifecycle Lifecycle { get; }
    public bool OverridesDuringTests { get; }

    public DependencyAttribute(Lifecycle lifecycle, bool overridesDuringTests = false)
    {
        Lifecycle = lifecycle;
        OverridesDuringTests = overridesDuringTests;
    }
}
```

### The IoC Discovery Class

Here is a class that discovers dependencies and registers them into a service collection, which is typical in a .NET environment using dependency injection:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Microsoft.Extensions.DependencyInjection;

public static class IoCDependencyDiscovery
{
    public static void RegisterDependencies(IServiceCollection services, Assembly assembly, bool isTestEnvironment = false)
    {
        var types = assembly.GetTypes();

        // Get all classes with the DependencyAttribute
        var implementations = types.Where(t => t.IsClass && !t.IsAbstract && t.GetCustomAttribute<DependencyAttribute>() != null);

        foreach (var implementation in implementations)
        {
            var attribute = implementation.GetCustomAttribute<DependencyAttribute>();
            var interfaces = implementation.GetInterfaces();

            if (!interfaces.Any())
            {
                throw new InvalidOperationException($"Class {implementation.Name} has no interfaces to register.");
            }

            foreach (var serviceType in interfaces)
            {
                if (isTestEnvironment && attribute.OverridesDuringTests)
                {
                    // For test environments, override previous registrations
                    RegisterService(services, serviceType, implementation, attribute);
                }
                else if (!isTestEnvironment)
                {
                    // Normal environment - only register if not already registered
                    if (!ServiceAlreadyRegistered(services, serviceType))
                    {
                        RegisterService(services, serviceType, implementation, attribute);
                    }
                }
            }
        }
    }

    private static void RegisterService(IServiceCollection services, Type serviceType, Type implementationType, DependencyAttribute attribute)
    {
        switch (attribute.Lifecycle)
        {
            case Lifecycle.Singleton:
                services.AddSingleton(serviceType, implementationType);
                break;
            case Lifecycle.Scoped:
                services.AddScoped(serviceType, implementationType);
                break;
            case Lifecycle.Transient:
                services.AddTransient(serviceType, implementationType);
                break;
            default:
                throw new ArgumentOutOfRangeException();
        }
    }

    private static bool ServiceAlreadyRegistered(IServiceCollection services, Type serviceType)
    {
        return services.Any(d => d.ServiceType == serviceType);
    }
}
```

### Usage

1. **Create your interfaces and implementations with attributes**:

```csharp
public interface IExampleService
{
    void DoSomething();
}

[Dependency(Lifecycle.Singleton)]
public class ExampleService : IExampleService
{
    public void DoSomething()
    {
        Console.WriteLine("Doing something...");
    }
}

[Dependency(Lifecycle.Transient, overridesDuringTests: true)]
public class ExampleTestService : IExampleService
{
    public void DoSomething()
    {
        Console.WriteLine("Doing something (test implementation)...");
    }
}
```

2. **Register dependencies in your `Startup` or equivalent setup class**:

```csharp
var services = new ServiceCollection();
IoCDependencyDiscovery.RegisterDependencies(services, Assembly.GetExecutingAssembly(), isTestEnvironment: true);

var serviceProvider = services.BuildServiceProvider();
var exampleService = serviceProvider.GetService<IExampleService>();
exampleService.DoSomething(); // Output depends on the environment
```

### Explanation

1. **Attributes**:
   - The `DependencyAttribute` defines the lifecycle and whether the implementation should override others during testing.

2. **IoC Discovery**:
   - The `RegisterDependencies` method scans an assembly for classes with `DependencyAttribute` and their interfaces.
   - It registers them in the `IServiceCollection` with the specified lifecycle.
   - For test environments, it allows overriding of implementations.

3. **Flexibility**:
   - The method supports both production and testing scenarios, ensuring the correct implementations are registered.

This approach provides a flexible way to manage dependencies in a .NET application using reflection and attributes.