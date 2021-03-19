# AzimoTestKit

AzimoTestKit is a framework which supports writing unit tests.

### Why
In Azimo we believe that software automatic testing is essential and unit tests should be a part of development work.
Unfortunately Swift has limited support for reflection what prevents us from effective Mock objects creation. Writing unit tests without mocks is really hard (sometimes impossible), that's why we started writing them for each test class. While doing it, we quickly realized that It doesn't go without having standarized interface for it. And this was the reason why we created `AzimoTestKit`.

### Main functionality

`FakeObject` is a protocol containing two properties:
* `invocations` - an array of all invocations performed on this object. 
* `invocationsToReturn` - an array that stores response which should be returned when someone will call a particular function.

That's it. Now we just need to fit those properties with expected data and use to validate our tests. In addition to `FakeObject` protocol, `AzimoTestKit` provides an `extension` to it with helpers methods as: `createInvocation`, `verify` and others.  

### Additional functionality

`AzimoTestKit` also gives us some validations tools like:

Type verification:
```swift
    func Verify<T>(_ value: Any, isTypeOf expectedType: T.Type)
    func Verify<T: Equatable>(_ value: Any, isEqualTo expectedValue: T)
    func VerifyAndCast<T>(_ value: Any, isTypeOf expectedType: T.Type) throws -> T
```
Dictionary verification:
```swift
    func Verify<T, Key, Value>(_ dictionary: [Key: Value], hasItemWithKey key: Key, ofType type: T.Type)
    func Verify<T:Equatable, Key, Value>(_ dictionary: [Key: Value], hasItemWithKey key: Key, equalTo expectedItem: T)
    func Verify<Key, Value:Equatable>(_ dictionary: [Key: Value], hasTheSameItemsAs expected: [Key: Value])
```
Optionals verification (thanks to Bartosz Polaczyk 👏:
 [more](https://www.slideshare.net/BartoszPolaczyk1/lets-meet-your-expectations))
 
```swift
    func unwrapped(file: StaticString = #file, line: UInt = #line) throws -> Wrapped
```
### Example

Let say we have the protocol called `Printer`:
```swift
    protocol Printer {
        func getIdentifier() -> String
        func print(_ message: String)
    }
```
And we use it in the class `PrintersController`
```swift
    class PrintersController {

      private let printers: [Printer]

      init (printers: [Printer]) {
          self.printers = printers
      }

      func print(_ message: String, on printerIdentifier: String) {
        guard let printer = printers.filter { $0.getIdentifier() == printerIdentifier } else { return }

        printer.print(message)
      }
    }
```
If we want to test `print()` function we should provide fake object of `Printer`. Unfortunately, we cannot create it automatically in code using reflection so we have to write them ourselves (or using some codes generator frameworks).

First let's create some helpers: `PrinterMethods` and `PrinterMethodsProperties`.
In this case, we use `enum`s but you can use whatever you want.
```swift
    enum PrinterMethods {
        case getIdentifier
        case print
    }

    enum PrinterMethodsProperties {
         case message
    }
```
Now let's create our `FakeObject``
```swift
    class FakePrinter: Printer, FakeObject {

      typealias MethodType = PrinterMethods

      var invocations = [FakeInvocation<MethodType>]()
      var invocationsToReturn = [FakeInvocationResponse<MethodType, Any?>]()

      func getIdentifier() -> String {
         let invocation = createInvocation(.getIdentifier)
         invocations.append(invocation)
         return responseValue(forInvocation: invocation, defaultValue: "some default value")
      }

      func print(_ message: String) {
        let parameters = [
           PrinterMethodsProperties.message.rawValue: message
        ]
        let invocation = createInvocation(.print, parameters: parameters)
        invocations.append(invocation)
      }
    }
```

Now let's use it in test
```swift
    class PrintersControllerTests: XCTestCase {

        var sut: PrintersController!
        var printer: FakePrinter!

        // setUp and tearDown are skipped for simplicity

        func testPrint_whenPrinterWithGivenIdExists_willCallPrintWithGivenMessage() throws {
           let expectedPrinterIdentifier = "uniqueId"
           let expectedMessage = "some important message to print"
           Given(printer, .getIdentifier, willReturn: expectedPrinterIdentifier)

           sut.print(expectedMessage, on: expectedPrinterIdentifier)

           Verify(printer, .getIdentifier) //one and only one invocation
           let invocation = printer.invocations(for: .print).first.unwrapped()
           let message: String = try invocation.parameter(forKey: PrinterMethodsProperties.message.rawValue)

           XCTAssertEqual(message, expectedMessage)
        }

    }
```


# Towards financial services available to all
We’re working throughout the company to create faster, cheaper, and more available financial services all over the world, and here are some of the techniques that we’re utilizing. There’s still a long way ahead of us, and if you’d like to be part of that journey, check out our [careers page](bit.ly/3vajnu6).
