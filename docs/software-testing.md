# Software Testing

## Test Pyramid

E2E > Integration > Unit

## Structuring test classes

Test Class by Method Grouping

SUT.cs > When.cs > Given_Xx_Then/Should_Xx()

## Group assertions

## Test Doubles

[Martin Fowler](https://martinfowler.com/articles/mocksArentStubs.html):

> Meszaros ([xUnit Patterns](http://xunitpatterns.com/Test%20Double%20Patterns.html)) uses the term **Test Double** as the generic term for any kind of pretend object used in place of a real object for testing purposes.

[xUnit Patterns](http://xunitpatterns.com/Test%20Double%20Patterns.html) definition of Test Doubles:

> - [Test Double](http://xunitpatterns.com/Test%20Double.html) We replace a component on which the SUT depends with a "test-specific equivalent."
> - [Configurable Test Double](http://xunitpatterns.com/Configurable%20Test%20Double.html) Configure a reusable Test Double with the values to be returned or verified during the fixture setup phase of a test.
> - [Fake](http://xunitpatterns.com/Fake%20Object.html) Replace a component that the SUT depends on with a much lighter-weight implementation.
> - [Stub](http://xunitpatterns.com/Test%20Stub.html) We replace a real object with a test-specific object that feeds the desired indirect inputs into the system under test.
> - [Spy](http://xunitpatterns.com/Test%20Spy.html) Use a Test Double to capture the indirect output calls made to another component by the SUT for later verification by the test.
> - [Mock](http://xunitpatterns.com/Mock%20Object.html) Replace an object the system under test (SUT) depends on with a test-specific object that verifies it is being used correctly by the SUT.

Mocks often lead to less DRY code as the same Mock setup behavior might be implemented in different test classes to satisfy SUT.

Stubs will quickly end up being Configurable Stubs or even Fakes with considerable logic to return specific objects based on given input parameters to mimic the real class. Such Configurable Stubs will require tests of the Stubs/Fakes it self.

Tests using Configurable Stubs are however less verbose and easier to read/understand than tests using Mocks.

[Humble Objects](http://xunitpatterns.com/Humble%20Object.html) are often needed to make code testable as some third-party libraries (like Azure) cannot be replaced by Test Doubles.
