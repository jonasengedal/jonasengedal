# C\# 10 samples

## CallerArgumentExpression

### Argument validation

Used in argument validation.

```C\#
public static partial class Argument
{
    public static T NotNull<T>([NotNull] this T? value, [CallerArgumentExpression("value")] string name = "")
        where T : class =>
        value is null ? throw new ArgumentNullException(name) : value;

    public static string NotNullOrWhiteSpace([NotNull] this string? value, [CallerArgumentExpression("value")] string name = "") =>
        string.IsNullOrWhiteSpace(value)
            ? throw new ArgumentException(string.Format(CultureInfo.CurrentCulture, Resources.StringCannotBeEmpty, name), name)
            : value;

    public static int NotNegative(this int value, [CallerArgumentExpression("value")] string name = "") =>
        value < 0
            ? throw new ArgumentOutOfRangeException(name, value, string.Format(CultureInfo.CurrentCulture, Resources.ArgumentCannotBeNegative, name))
            : value;
}

public record Person
{
    public Person(string name, int age, Uri link) => 
        //(this.Name, this.Age, this.Link) = (name.NotNullOrWhiteSpace(), age.NotNegative(), link.NotNull().///ToString());
        this.Name = name.NotNullOrWhiteSpace();
        this.Age = age.NotNegative();
        this.Link = link.NotNull().ToString();
        // Compiled to:
        // this.Name = Argument.NotNullOrWhiteSpace(name, "name");
        // this.Age = Argument.NotNegative(age, "age");
        // this.Link = Argument.NotNull(link, "link").ToString();

    public string Name { get; }
    public int Age { get; }
    public string Link { get; }
}
```

Sample code is taken from [Dixin's Blog](https://weblogs.asp.net/dixin/csharp-10-new-feature-callerargumentexpression-argument-check-and-more).

### Assertion and logging

Used in assertion and logging.

```C\#

[Conditional("DEBUG")]
static void Assert(bool condition, [CallerArgumentExpression("condition")] string expression = "")
{
    if (!condition)
    {
        Environment.FailFast($"'{expression}' is false and should be true.");
    }
}

Assert(y > TimeSpan.Zero);
// Compiled to:
Assert(y > TimeSpan.Zero, "y > TimeSpan.Zero");

[Conditional("DEBUG")]
static void Log<T>(T value, [CallerArgumentExpression("value")] string expression = "")
{
    Trace.WriteLine($"'{expression}' has value '{value}'");
}

Log(Math.Min(Environment.ProcessorCount, x));
// Compiled to:
Log(Math.Min(Environment.ProcessorCount, x), "Math.Min(Environment.ProcessorCount, x)");
```

Sample code is taken from [Dixin's Blog](https://weblogs.asp.net/dixin/csharp-10-new-feature-callerargumentexpression-argument-check-and-more).
