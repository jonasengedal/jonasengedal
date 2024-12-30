# Software Design #

## SOLID Principles ##

The **SOLID** principles are a set of five guidelines for writing maintainable and scalable object-oriented software. Each principle addresses specific challenges in software design, promoting cleaner, more modular code.

### Summary of SOLID Principles ###

1. **SRP**: A class should have one and only one reason to change.
2. **OCP**: Extend functionality without modifying existing code.
3. **LSP**: Subtypes should be substitutable for their base types.
4. **ISP**: Avoid forcing classes to implement irrelevant methods.
5. **DIP**: Depend on abstractions, not concrete implementations.

### 1. Single Responsibility Principle (SRP) ###

**Definition**: A class should have only one reason to change, meaning it should only have one responsibility.


```csharp
// Without SRP: A single class handling both user management and notification
public class UserManager
{
    public void CreateUser(string name)
    {
        // Logic for creating a user
    }

    public void SendEmailNotification(string email, string message)
    {
        // Logic for sending email
    }
}

// With SRP: Separate classes for user management and notification
public class UserManager
{
    public void CreateUser(string name)
    {
        // Logic for creating a user
    }
}

public class EmailNotifier
{
    public void SendEmail(string email, string message)
    {
        // Logic for sending email
    }
}
```

### 2. Open/Closed Principle (OCP) ###

**Definition**: Classes should be open for extension but closed for modification.

```csharp
// Without OCP: Modifying the class to add new functionality
public class DiscountCalculator
{
    public double CalculateDiscount(string customerType, double totalAmount)
    {
        if (customerType == "Regular")
        {
            return totalAmount * 0.1;
        }
        else if (customerType == "Premium")
        {
            return totalAmount * 0.2;
        }
        return 0;
    }
}

// With OCP: Extending functionality without modifying the existing class
public abstract class Discount
{
    public abstract double Calculate(double totalAmount);
}

public class RegularDiscount : Discount
{
    public override double Calculate(double totalAmount) => totalAmount * 0.1;
}

public class PremiumDiscount : Discount
{
    public override double Calculate(double totalAmount) => totalAmount * 0.2;
}

// Usage:
public class DiscountCalculator
{
    public double CalculateDiscount(Discount discount, double totalAmount)
    {
        return discount.Calculate(totalAmount);
    }
}
```

### 3. Liskov Substitution Principle (LSP) ###

**Definition**: Objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program.

```csharp
// Violating LSP: A subclass alters the behavior in an unexpected way
public class Bird
{
    public virtual void Fly()
    {
        Console.WriteLine("Flying");
    }
}

public class Penguin : Bird
{
    public override void Fly()
    {
        throw new NotSupportedException("Penguins can't fly!");
    }
}

// Following LSP: Redesigning the hierarchy
public abstract class Bird
{
    public abstract void Move();
}

public class FlyingBird : Bird
{
    public override void Move()
    {
        Console.WriteLine("Flying");
    }
}

public class Penguin : Bird
{
    public override void Move()
    {
        Console.WriteLine("Swimming");
    }
}
```

### 4. Interface Segregation Principle (ISP) ###

**Definition**: A class should not be forced to implement interfaces it does not use.

```csharp
// Without ISP: A large interface that forces unnecessary implementation
public interface IWorker
{
    void Work();
    void Eat();
}

public class Robot : IWorker
{
    public void Work()
    {
        Console.WriteLine("Working");
    }

    public void Eat()
    {
        // Robots don't eat, so this method is irrelevant
        throw new NotImplementedException();
    }
}

// With ISP: Splitting the interface
public interface IWorkable
{
    void Work();
}

public interface IEatable
{
    void Eat();
}

public class Human : IWorkable, IEatable
{
    public void Work()
    {
        Console.WriteLine("Working");
    }

    public void Eat()
    {
        Console.WriteLine("Eating");
    }
}

public class Robot : IWorkable
{
    public void Work()
    {
        Console.WriteLine("Working");
    }
}
```

### 5. Dependency Inversion Principle (DIP) ###

**Definition**: High-level modules should not depend on low-level modules. Both should depend on abstractions.

```csharp
// Without DIP: High-level class depends on a low-level implementation
public class EmailService
{
    public void SendEmail(string message)
    {
        Console.WriteLine($"Sending email: {message}");
    }
}

public class Notification
{
    private EmailService _emailService = new EmailService();

    public void Notify(string message)
    {
        _emailService.SendEmail(message);
    }
}

// With DIP: High-level class depends on an abstraction
public interface IMessageService
{
    void SendMessage(string message);
}

public class EmailService : IMessageService
{
    public void SendMessage(string message)
    {
        Console.WriteLine($"Sending email: {message}");
    }
}

public class Notification
{
    private readonly IMessageService _messageService;

    public Notification(IMessageService messageService)
    {
        _messageService = messageService;
    }

    public void Notify(string message)
    {
        _messageService.SendMessage(message);
    }
}

// Usage:
var emailService = new EmailService();
var notification = new Notification(emailService);
notification.Notify("Hello!");
```