<div align='center'>

# TypeScript Blog
</div>

## Table of Contents

- [1. What are some differences between interfaces and types in TypeScript](#1-what-are-some-differences-between-interfaces-and-types-in-typescript)
- [2. What is the use of the keyof keyword in TypeScript Provide an example](#2-what-is-the-use-of-the-keyof-keyword-in-typescript-provide-an-example)
- [3. Explain the difference between any unknown and never types in TypeScript](#3-explain-the-difference-between-any-unknown-and-never-types-in-typescript)
- [4. What is the use of enums in TypeScript Provide an example of a numeric and string enum](#4-what-is-the-use-of-enums-in-typescript-provide-an-example-of-a-numeric-and-string-enum)
- [5. What is type inference in TypeScript? Why is it helpful?](#5-what-is-type-inference-in-typescript-why-is-it-helpful)
- [6. How does TypeScript help in improving code quality and project maintainability?](#6-how-does-typescript-help-in-improving-code-quality-and-project-maintainability)
- [7. Provide an example of using union and intersection types in TypeScript.](#7-provide-an-example-of-using-union-and-intersection-types-in-typescript)


<br>

## 1. What are some differences between `interfaces` and `types` in TypeScript?

both `interface` and `type` can be used to describe the shape of an object, but there are some key differences between them. Here's a breakdown:

### ✅ A. Extension / Inheritance

**Interface:** Supports extension via `extends`, including multiple interfaces.

```ts
interface A { x: number }
interface B extends A { y: number }
```

**Type**: Supports extension via intersections `(&)`.

```ts
type A = { x: number };
type B = A & { y: number };
```
### ✅ B. Declaration Merging

**Interface**: Can be `merged` if defined multiple times.

```ts
interface User { name: string }
interface User { age: number }

const u: User = { name: "John", age: 30 };
```

**Type:** Cannot be re-declared. Will cause an error.

### ✅ C. Use Cases Beyond Objects

**Type:** More flexible. Can represent primitive types, unions, tuples, etc.

```ts
type ID = string | number;
type Pair = [string, number];
```

**Interface:** Only used for describing object shapes or class contracts.

### ✅ D. Implements with Classes

**Interface:** Commonly used with implements in classes.

```ts
interface Printable {
  print(): void;
}

class Report implements Printable {
  print() {
    console.log("Printing...");
  }
}
```

**Type:** Not typically used with implements, though possible with object types.

### ✅ E. Readability & Community Convention

- Use `interface` for **object structures** (especially public APIs and OOP).
- Use `type` for **complex compositions**, unions, tuples, and primitives.


### Summary

| Feature                | `interface`               | `type`                                 |
|------------------------|---------------------------|-----------------------------------------|
| Object shape           | ✅ Yes                    | ✅ Yes                                  |
| Union / Tuple / Alias  | ❌ No                     | ✅ Yes                                  |
| Declaration merging    | ✅ Yes                    | ❌ No                                   |
| Implements in class    | ✅ Yes                    | ✅ (only for object types)              |
| Extending              | ✅ via `extends`          | ✅ via intersection (`&`)               |



<br>


## 2. What is the use of the `keyof` keyword in TypeScript? Provide an example.

The `keyof` keyword in TypeScript is used to create a ***union type of all the property names (keys)*** of a given object type. It is particularly useful when you want to work with the keys of a type in a type-safe way.

### 🔹 Use Case 

It ensures you're only using valid keys of an object type, often useful in **generics, utility functions, or mapped types.**

### ✅ Example

```ts
interface Person {
  name: string;
  age: number;
  isStudent: boolean;
}

type PersonKeys = keyof Person;
// Equivalent to: "name" | "age" | "isStudent"
```

Now you can use it like this:

```ts
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

const person: Person = {
  name: "Alice",
  age: 25,
  isStudent: true
};

const age = getProperty(person, "age");       // Type: number
const isStudent = getProperty(person, "isStudent"); // Type: boolean
```

### 📌 Summary

- `keyof` is a **type operator** that extracts the **keys** of a type as a union.
- Helps in **creating generic, type-safe functions.**
- Often used with `T[K]` **index access.**

<br>

## 3. Explain the difference between `any`, `unknown`, and `never` types in TypeScript.


| Type      | Description                                                                      | Use Case                                                     | Safety Level     |
| --------- | -------------------------------------------------------------------------------- | ------------------------------------------------------------ | ---------------- |
| `any`     | Disables type checking for a variable. You can assign or access anything.        | When you don’t care about the type or migrating JS code.     | ❌ Least safe     |
| `unknown` | Accepts any value like `any`, but requires type-checks before use.               | When accepting unknown input safely (e.g., APIs, user input) | ✅ Safer than any |
| `never`   | Represents values that never occur (e.g., functions that throw or loop forever). | For functions that never return or unreachable code.         | ✅ Fully safe     |


### ✅ `any` Example:

```ts
let value: any = "Hello";
value = 42;        // OK
value.toUpperCase(); // OK (no error even if value is not a string)
```

⚠️ **No type safety** — you can call any method even if it doesn’t exist.


### ✅ `unknown` Example:

```ts
let value: unknown = "Hello";
value = 42;        // OK
// value.toUpperCase(); // ❌ Error: Object is of type 'unknown'

if (typeof value === "string") {
  console.log(value.toUpperCase()); // ✅ Safe to use
}
```
🔒 **Type-safe:** you must narrow the type before usage.

### ✅ `never` Example:

```ts
function throwError(message: string): never {
  throw new Error(message);
}

function infiniteLoop(): never {
  while (true) {}
}
```
🧠 Used to represent **unreachable code** or **non-returning functions**.

### Summary : 

- Use `any` if you **don’t want type checking**.

- Use `unknown` if you want to **accept any value but ensure safety** before using it.

- Use `never` when a function **does not return at all** (e.g., throws or loops infinitely).


<br>

## 4. What is the use of `enums` in TypeScript? Provide an example of a numeric and string enum.

Enums in TypeScript are used to define a set of **named constants** —making it easier to document intent, create readable code, and reduce the chances of bugs due to invalid values.

### 🔹 Why Use Enums?

- Enums improve code readability.
- They allow you to define a **finite set of possible values**.
- Prevents the use of arbitrary strings or numbers.

### 🔢 Numeric Enum Example:

```ts
enum Direction {
  Up,      // 0
  Down,    // 1
  Left,    // 2
  Right    // 3
}

const move = Direction.Up;
console.log(move); // Output: 0
```
Numeric enums auto-increment from `0` by default. You can also manually assign numbers:

```ts
enum Status {
  Pending = 1,
  Approved = 2,
  Rejected = 3
}
```

### 🔤 String Enum Example:

```ts
enum Direction {
  Up = "UP",
  Down = "DOWN",
  Left = "LEFT",
  Right = "RIGHT"
}

const move = Direction.Left;
console.log(move); // Output: "LEFT"
```
String enums don’t auto-increment—you must define each value explicitly.

### ✅ Summary Table

| Enum Type    | Values  | Auto-increment | Example Values |
| ------------ | ------- | -------------- | -------------- |
| Numeric Enum | Numbers | ✅ Yes          | `0, 1, 2, ...` |
| String Enum  | Strings | ❌ No           | `"UP", "DOWN"` |

<br>

## 5. What is `type inference` in TypeScript? Why is it helpful?

**Type inference** in TypeScript is the ability of the TypeScript compiler to **automatically determine the type** of a variable or expression **without explicit type annotations**.

### ✅ Example:

```ts
let message = "Hello, world!"; // TypeScript infers this as string
let count = 10;                // TypeScript infers this as number
```

Here, TypeScript automatically understands:
- `message` is of type `string`
- `count` is of type `number`

You don’t need to explicitly write:

```ts
let message: string = "Hello, world!";
let count: number = 10;
```

### Why is it helpful?

| Feature                      | Description                                                              |
| ---------------------------- | ------------------------------------------------------------------------ |
| 🔍 **Reduces boilerplate**   | You don’t have to annotate every variable explicitly.                    |
| ✅ **Improves readability**   | Cleaner code without excessive type declarations.                        |
| 💡 **Smart suggestions**     | IDEs like VS Code offer intelligent autocomplete and type checking.      |
| 🧱 **Maintains type safety** | Even without annotations, your code remains type-safe and error-checked. |


### Inferred Return Types
TypeScript can also infer the return type of functions:

```ts
function add(a: number, b: number) {
  return a + b; // Inferred as number
}
```

### ✅ Summary :

Type inference makes TypeScript powerful and developer-friendly by striking a balance between **type safety** and **concise syntax**. It helps catch errors early while keeping your code clean.


<br>

## 6. How does TypeScript help in improving code quality and project maintainability?

TypeScript is a **statically typed superset of JavaScript** that compiles to plain JavaScript. It introduces **types, interfaces, and compile-time checking**, which help developers catch errors early and write scalable, maintainable code.

### ✅ How TypeScript Improves Code Quality ?

| Feature                              | Benefit                                                                    |
| ------------------------------------ | -------------------------------------------------------------------------- |
| **Static Typing**                    | Catches type-related bugs at compile time rather than at runtime.          |
| **Intelligent IDE Support**          | Offers autocompletion, inline documentation, and real-time error hints.    |
| **Early Error Detection**            | Detects undefined variables, incorrect function arguments, etc.            |
| **Refactoring Safety**               | Easier and safer to rename variables, methods, or types across a codebase. |
| **Type Inference**                   | Reduces the need for explicit type annotations while maintaining safety.   |
| **Strong Contracts with Interfaces** | Helps define clear API contracts for functions, components, and classes.   |


### 🛠️ How TypeScript Improves Maintainability ?

| Feature                                      | Benefit                                                              |
| -------------------------------------------- | -------------------------------------------------------------------- |
| **Modular Design with Interfaces and Types** | Encourages clean, modular architecture.                              |
| **Self-Documenting Code**                    | Code becomes more readable and understandable with meaningful types. |
| **Better Collaboration**                     | Teams can work more efficiently with shared type definitions.        |
| **Scalable Codebase**                        | Easy to manage growing applications with consistent typing.          |
| **Tooling Ecosystem**                        | Seamless integration with ESLint, Prettier, testing frameworks, etc. |


### 📌 Example :

Without TypeScript:

```ts
function greet(user) {
  return "Hello " + user.name.toUpperCase();
}
```

With TypeScript:

```ts
function greet(user: { name: string }) {
  return "Hello " + user.name.toUpperCase();
}
```
Here, TypeScript will throw an error if user.name is not a string, preventing bugs before the code runs.

### 🧠 Summary

TypeScript enhances:
- ***Developer productivity***
- ***Error prevention***
- ***Code maintainability***
- ***Team collaboration***

It’s particularly powerful in **large-scale applications** where clean architecture and strict type contracts are critical.


<br>

## 7. Provide an example of using `union` and `intersection` types in TypeScript.

### 🔀 Union Types (`|`)

A **union type** allows a value to be **one of several types**.

**✅ Example:**

```ts
function printId(id: string | number) {
  console.log("Your ID is: " + id);
}

printId(101);        // OK
printId("ABC123");   // OK
```

- `id` can be either a `string` or a `number`.
- Union types are useful when a variable can hold multiple types of values.

### ➕ Intersection Types (`&`)

An **intersection type** combines multiple types into **one**, requiring that **all** conditions be met.

**✅ Example:**

```ts
interface Name {
  name: string;
}

interface Age {
  age: number;
}

type Person = Name & Age;

const person: Person = {
  name: "Alice",
  age: 30
};
```

- `Person` must have **both** `name` and `age` properties.
- Intersection types are used when you want to merge multiple type definitions.

### 🧠 Summary

| Type             | Symbol | Meaning                                 | Example             |                    |
| ---------------- | ------ | --------------------------------------- | ------------------- | ------------------ |
| **Union Type**   | `\|`     | Choose one among all types                                      | One type OR another | `string \| number` |
| **Intersection** | `&`    | Combine multiple types (ALL must match) | One type AND another (`Name & Age`)       |       `string & number`             |
# PH-Level2-B5-Assignment-2
