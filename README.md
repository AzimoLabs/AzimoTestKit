# AzimoTestKit

AzimoTestKit is a framework which supports writing tests.

### Why

First of all, Swift has limited support for reflection which prevents us from automatically creation Mock objects. Additionally, in Azimo we believe that tests are really important and unit tests should be part of development. As we know that writing unit tests without mock is really hard (or sometimes impossible) we started writing them for each test class. Quickly we realize that we need some standardized interface for it.

### Main functionality

`FakeObject` is a protocol containing two properties. One is `invocations` which is an array of all invocations performed on this object. Other is `invocationsToReturn` which also is an array but this time it stores response which should be returned when someone will call a particular function.

That's it. Now we just need to fit those properties with expected data and use to validate our tests. Additional to `FakeObject` protocol `AzimoTestKit` provide an `extension` to it with helpers methods as: `createInvocation`, `verify` and others.  


### Additional functionality

`AzimoTestKit` also gave us some validations tools as:

For verifying type:

    func Verify<T>(_ value: Any, isTypeOf expectedType: T.Type)
    func Verify<T: Equatable>(_ value: Any, isEqualTo expectedValue: T)
    func VerifyAndCast<T>(_ value: Any, isTypeOf expectedType: T.Type) throws -> T

for dictionary:

    func Verify<T, Key, Value>(_ dictionary: [Key: Value], hasItemWithKey key: Key, ofType type: T.Type)
    func Verify<T:Equatable, Key, Value>(_ dictionary: [Key: Value], hasItemWithKey key: Key, equalTo expectedItem: T)
    func Verify<Key, Value:Equatable>(_ dictionary: [Key: Value], hasTheSameItemsAs expected: [Key: Value])

or for Optional (thanks to Bartosz Polaczyk 👏:
 [more](https://www.slideshare.net/BartoszPolaczyk1/lets-meet-your-expectations))

    func unwraped(file: StaticString = #file, line: UInt = #line) throws -> Wrapped

### Example of use

Let say we have some protocol called `Printer`:

    protocol Printer {
        func getIdentifier() -> String
        func print(_ message: String)
    }

And we use it in class `PrintersController`

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

If we want to test `print()` function we should provide fake object of `Printer`. Unfortunately, we can not create it automatically in code using reflection so we have to write them ourselves (or using some codes generator frameworks).

First let's create some helpers: `PrinterMethods` and `PrinterMethodsProperties`.
In this case, we use `enum`s but you can use whatever you want.

    enum PrinterMethods {
        case getIdentifier
        case print
    }

    enum PrinterMethodsProperties {
         case message
    }

Now let's create our `FakeObject``

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


Now let's use it in test

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
