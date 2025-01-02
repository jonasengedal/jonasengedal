# Software Development Principles

The software development process begins with a commitment to *making it work*, ensuring the software functions as intended while remaining focused on addressing immediate pain points — a hallmark of Pain-Driven Development.

As functionality stabilizes, the focus shifts to *making it right*, applying SOLID principles to enhance maintainability and scalability. The design is clean and modular (SRP) with segregated interfaces (ISP) implemented by decoupled and adaptable (DIP) code that enables extension without modification (OCP), and ensuring robust polymorphism (LSP).  

Throughout, YAGNI reminds us to avoid over-engineering; features are implemented only when proven necessary. DRY principles ensure every piece of knowledge in the codebase is singular, minimizing redundancy and reducing future maintenance costs.

Finally, *making it fast* follows naturally, as a well-structured, lean codebase allows for performance optimizations without sacrificing clarity or correctness.

Modified content from ChatGPT.

## Principles

- [Make it Work. Make it Right. Make it Fast](#make-it-work-make-it-right-make-it-fast)
- [Pain Driven Development](#pain-driven-development)
- [YAGNI](#yagni-you-arent-gonna-need-it)
- [DRY](#dry-dont-repeat-yourself)
- [SOLID Principles](#solid-principles)

See a [full list of software development principles at DevIQ](https://deviq.com/principles/principles-overview).

### Make it Work, Make it Right, Make it Fast

Start by building a functional solution, ensuring correctness through robust testing and adherence to requirements. Once it works reliably, refine the design to align with SOLID principles, making it extensible and maintainable. Finally, optimize performance where necessary, but only when bottlenecks arise.

[Read more](./make-it-work-right-fast.md)

### Pain-Driven Development

Focus on solving real, tangible pain points first. Address immediate needs while deferring less critical enhancements to avoid overengineering.

[Dev IQ](https://deviq.com/practices/pain-driven-development)

[Weekly dev tips](https://www.weeklydevtips.com/episodes/010):

> follow YAGNI and build only what is required today, but recognize when you'll "need it" by the pain the current design causes you as you try to work around/with it.

### SOLID Principles

- **Single Responsibility Principle (SRP)**: Each module or class should have a single, clear purpose.
- **Open/Closed Principle (OCP)**: Design components to be open for extension but closed for modification, enhancing flexibility while preserving stability.
- **Liskov Substitution Principle (LSP)**: Subtypes must be interchangeable with their base types without altering system behavior.
- **Interface Segregation Principle (ISP)**: Interfaces should be specific to client needs, avoiding unnecessary dependencies.
- **Dependency Inversion Principle (DIP)**: Depend on abstractions, not concrete implementations, to promote decoupling.

[Read more and examples](./solid-principles.md).

### YAGNI (You Aren’t Gonna Need It)

Resist the temptation to build features or capabilities you "might" need in the future. Focus on what is necessary now to avoid bloat and complexity.

[Dev IQ](https://deviq.com/principles/yagni)

### DRY (Don’t Repeat Yourself)

Eliminate redundancy by abstracting reusable logic and leveraging shared components, reducing maintenance overhead.

[Dev IQ](https://deviq.com/principles/dont-repeat-yourself)
