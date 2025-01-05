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

[Mocks and Stubs often breakes the encapsulation](https://blog.ploeh.dk/2022/10/17/stubs-and-mocks-break-encapsulation/) of interface contracts. That might not be a problem but often is. Therefore, rather use Fakes instead.

[Fakes are more complex to implement](https://blog.ploeh.dk/2023/11/13/fakes-are-test-doubles-with-contracts/) as they have to obey the contract implied by the interface being faked, e.g. mainting in memory state.

Consider letting the Fake use a combination of Configurable Stub and Spy to store state and capture calls to the Fake object for easier setup and assertion in tests.

Fakes are not easy to setup throwing exceptions, if that should at all be needed. [Mark Seeman has an article about this](https://blog.ploeh.dk/2024/02/26/testing-exceptions/). In this case the Configurable Stub can be used or simply use a Mock that single test case.

Use AutoFixture to create Mocks and Fakes to keep code DRY and less verbose.

[Humble Objects](http://xunitpatterns.com/Humble%20Object.html) are often needed to make code testable as some third-party libraries (like Azure) cannot be replaced by Test Doubles.
