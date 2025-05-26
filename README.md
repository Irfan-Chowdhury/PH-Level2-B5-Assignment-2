<div align='center'>

# PostgreSQL Blog
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

# 1. What is PostgreSQL?

**PostgreSQL**  হলো একটি **ওপেন সোর্স, অবজেক্ট-রিলেশনাল ডেটাবেইস ম্যানেজমেন্ট সিস্টেম (RDBMS)**। এটি ডেটা সংরক্ষণ, রক্ষণাবেক্ষণ, বিশ্লেষণ এবং পরিচালনার জন্য ব্যবহৃত হয়।

---

### 🔑 PostgreSQL-এর প্রধান বৈশিষ্ট্য:

1. **ওপেন সোর্স** — বিনামূল্যে ব্যবহার করা যায় এবং কাস্টমাইজও করা যায়।
2. **অত্যন্ত শক্তিশালী** — জটিল কুয়েরি, সাব-কুয়েরি, ট্রিগার, ভিউ, স্টোরড প্রোসিডিউর ইত্যাদি সাপোর্ট করে।
3. **ACID কমপ্লায়েন্ট** — ডেটার নির্ভরযোগ্যতা ও সুরক্ষা নিশ্চিত করে।
4. **Cross-platform** — Windows, Linux, macOS সহ বিভিন্ন সিস্টেমে চলে।
5. **Extensible** — কাস্টম ফাংশন, টাইপ, অপারেটর অ্যাড করা যায়।
6. **Geospatial & JSON Support** — GIS ডেটা এবং NoSQL টাইপের ডেটা ব্যবস্থাপনাও করা যায়।

---

### ব্যবহার কোথায় হয়?

* বড় বড় Web Application (যেমন: Django, Laravel, Node.js প্রজেক্টে)
* Business Intelligence (BI) & Reporting
* Data Analytics
* Government ও Finance সেক্টরের ডেটা প্রসেসিং

---

### উদাহরণ:

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
```

---

### সংক্ষেপে:

> **PostgreSQL** একটি উন্নতমানের SQL-ভিত্তিক ডেটাবেইস যা বড় ও জটিল অ্যাপ্লিকেশনেও নির্ভরযোগ্যভাবে কাজ করে।

<br>

# 2. What is the purpose of a database schema in PostgreSQL?


**Schema** হচ্ছে একটি **লজিক্যাল কাঠামো (logical structure)**, যা ডেটাবেইসের ভিতরে তৈরি করা হয় এবং যেখানে টেবিল, ভিউ, ফাংশন, ইনডেক্স, সিকোয়েন্স ইত্যাদি রাখা হয়।

যেমন একটা বইয়ে Chapter থাকে বিভিন্ন বিষয়ের জন্য, ঠিক তেমনভাবেই **Schema** হলো ডেটাবেইসের "Chapter" বা "Section" — যেখানে নির্দিষ্ট উদ্দেশ্যের জন্য টেবিল ও অন্যান্য অবজেক্ট রাখা হয়।

---

##  Schema ব্যবহার করার উদ্দেশ্য ও উপকারিতা:

### 1. **বড় ডেটাবেইসকে ছোট ছোট ভাগে ভাগ করে সংগঠিত রাখা যায়**

ধরা যাক আপনি একটি বড় সিস্টেম তৈরি করছেন যেখানে HR, Accounting, Sales, এবং Admin—এভাবে আলাদা আলাদা module আছে। তাহলে আপনি `hr`, `accounts`, `sales`, `admin` নামে আলাদা schema তৈরি করে টেবিলগুলো আলাদা করে রাখতে পারবেন।

এতে করে ডেটাবেইস **clean, readable এবং manageable** থাকে।

---

### 2. **একই ডেটাবেইসে একই নামের টেবিল রাখা যায়**

যেহেতু স্কিমা ভিন্ন, তাই একই ডেটাবেইসে আপনি নিচের মতো টেবিল রাখতে পারবেন:

* `hr.employees`
* `sales.employees`

দুটোর কাজ আলাদা হলেও নাম একই, স্কিমা আলাদা হওয়ায় কোনো সমস্যা নেই।

---

### 3. **পারমিশন ও সিকিউরিটি কন্ট্রোল করা যায়**

প্রতিটি স্কিমা’র উপর ভিত্তি করে আপনি আলাদা user permission সেট করতে পারেন। ধরুন, HR schema-তে শুধু HR ডিপার্টমেন্টের ইউজারদের read/write access দেওয়া যাবে, অন্যরা পারবে না।

এতে করে ডেটার **নিরাপত্তা ও access control** ভালোভাবে নিশ্চিত করা যায়।

---

### 4. **ডেভেলপমেন্ট ও টেস্টিং সহজ হয়**

আপনার production database আছে। আপনি যদি নতুন ফিচার টেস্ট করতে চান, তাহলে একটা `test` বা `dev` schema তৈরি করে সেখানে আলাদা টেবিল বানিয়ে কাজ করতে পারেন, মূল টেবিল বা ডেটা ছাড়াই।

---

###  উদাহরণ:

```sql
-- Schema তৈরি করুন
CREATE SCHEMA hr;

-- Schema-এর ভিতরে টেবিল তৈরি করুন
CREATE TABLE hr.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);

-- Data Insert
INSERT INTO hr.employees (name, department)
VALUES ('Irfan Chowdhury', 'Software');

-- Data Fetch
SELECT * FROM hr.employees;
```

---

##  PostgreSQL-এ Default Schema:

PostgreSQL-এ ডিফল্টভাবে `public` নামক একটি স্কিমা থাকে। আপনি যদি কোনো স্কিমা না দেন, তাহলে সব টেবিল, ফাংশন ইত্যাদি এই `public` স্কিমা-তেই তৈরি হয়।

---

##  সংক্ষেপে:

> PostgreSQL-এ Schema হলো একটি **logical container**, যা ডেটাবেইসের অবজেক্টগুলোকে **গ্রুপ করে**, **নিরাপদ রাখে**, এবং **পরিচ্ছন্নভাবে সংগঠিত** করে।

---

##  Schema ব্যবহার করলে আপনি পাবেন:

* বেশি কনট্রোল
* ভালো organization
* নিরাপত্তা
* উন্নত স্কেলেবিলিটি


<br>

# 3. Explain the `Primary Key` and `Foreign Key` concepts in PostgreSQL.


**Primary Key** হলো একটি টেবিলের এমন একটি কলাম (বা একাধিক কলামের সমন্বয়), যার মান **অন্য কারও সঙ্গে মিলতে পারে না (unique)** এবং কখনো **`NULL`** হতে পারে না। এটি একটি **টেবিলের প্রতিটি রেকর্ডকে আলাদা করে চিহ্নিত** করে।

###  বৈশিষ্ট্য:

* প্রতিটি টেবিলে মাত্র **একটি Primary Key** থাকতে পারে।
* এটি **স্বয়ংক্রিয়ভাবে unique constraint ও not null constraint** ধারণ করে।
* সাধারণত `id` ফিল্ডটি Primary Key হিসেবে ব্যবহৃত হয়।

###  উদাহরণ:

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
```

এখানে `student_id` হচ্ছে Primary Key — যার মান প্রতিটি স্টুডেন্টের জন্য আলাদা হবে।

---

##  **Foreign Key (ফরেইন কি) কী?**

**Foreign Key** হলো এমন একটি কলাম যা অন্য একটি টেবিলের Primary Key-এর সাথে **সম্পর্ক স্থাপন করে**। এর মাধ্যমে দুটি টেবিলের মধ্যে **রিলেশন (relationship)** তৈরি হয়।

### বৈশিষ্ট্য:

* এটি **parent table** এর Primary Key-কে রেফার করে।
* Foreign Key এর মাধ্যমে **data integrity** বজায় রাখা যায় — অর্থাৎ ভুল রেফারেন্স দেওয়া যাবে না।
* একই টেবিলে একাধিক Foreign Key থাকতে পারে।

### উদাহরণ:

```sql
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

এখানে:

* `courses.course_id` হলো parent table-এর Primary Key
* `enrollments.course_id` হলো Foreign Key → যেটা `courses.course_id` কে রেফার করছে।

এতে করে নিশ্চিত হয় যে **enrollments টেবিলে থাকা প্রতিটি course\_id অবশ্যই courses টেবিলে থাকতে হবে**।

---

##  সংক্ষেপে তুলনা:

| বিষয়            | Primary Key                           | Foreign Key                                        |
| --------------- | ------------------------------------- | -------------------------------------------------- |
| মান             | ইউনিক এবং Not Null                    | অন্য টেবিলের Primary Key থেকে আসা                  |
| উদ্দেশ্য        | প্রতিটি রেকর্ডকে আলাদা করে শনাক্ত করা | টেবিলের মধ্যে সম্পর্ক তৈরি করা                     |
| সংখ্যা          | একটি টেবিলে মাত্র ১টি                 | একাধিক থাকতে পারে                                  |
| ডেটা ইনটিগ্রিটি | সরাসরি নিশ্চয়তা দেয়                  | parent টেবিলের ডেটা অনুযায়ী child ডেটা নিশ্চিত করে |

---

##  উদাহরণ :

ধরুন `students` টেবিলে প্রতিটি ছাত্রের একটি আইডি আছে (Primary Key) এবং `enrollments` টেবিলে জানা আছে, কে কোন কোর্সে ভর্তি হয়েছে। এখানে প্রতিটি `enrollments.student_id` ফরেইন কি হিসাবে `students.student_id` কে রেফার করে।

<br>

# 4. What is the difference between the `VARCHAR` and `CHAR` data types?

নিশ্চয়ই! নিচে `VARCHAR` এবং `CHAR` ডেটা টাইপের মধ্যে পার্থক্য বাংলায় ব্যাখ্যা করা হলো:

### 🔹 `VARCHAR(n)` (Variable Character)

* `VARCHAR` মানে **ভ্যারিয়েবল দৈর্ঘ্যের স্ট্রিং**, অর্থাৎ যেখানে আপনি যতটুকু লেখেন ঠিক ততটুকু জায়গা ব্যবহার করে।
* `n` হলো সর্বোচ্চ অক্ষরের সংখ্যা।
* যদি আপনি `VARCHAR(10)` দেন, তবে আপনি সর্বোচ্চ ১০টি অক্ষর রাখতে পারবেন।
* কিন্তু যদি আপনি "Cat" লেখেন (৩টি অক্ষর), তাহলে শুধু ৩টি অক্ষরের জায়গাই ব্যবহার হবে।

✅ **ব্যবহার করুন যখন:**

* ভিন্ন ভিন্ন দৈর্ঘ্যের টেক্সট সংরক্ষণ করতে চান।
* স্টোরেজ সাশ্রয়ী হতে চান।

---

### 🔹 `CHAR(n)` (Fixed Character)

* `CHAR` মানে **নির্দিষ্ট দৈর্ঘ্যের স্ট্রিং**, অর্থাৎ প্রতিটি ইনপুটকেই `n` দৈর্ঘ্যের করা হয়।
* যদি আপনি `CHAR(10)` দেন এবং "Cat" লেখেন, তাহলে **বাকি ৭টি জায়গা ফাঁকা (space)** দিয়ে পূরণ করা হবে।
* সব সময় নির্দিষ্ট দৈর্ঘ্যের জায়গা সংরক্ষণ করে, তাই কিছুটা **স্টোরেজ বেশি** লাগে।

✅ **ব্যবহার করুন যখন:**

* সব ইনপুট একই দৈর্ঘ্যের হবে (যেমন: পিন, কোড ইত্যাদি)।
* পারফরম্যান্স গুরুত্বপূর্ণ (ফিক্সড সাইজ হওয়ায় দ্রুত প্রসেস করা যায়)।

---

### 📊 তুলনামূলক টেবিল:

| বিষয়               | `VARCHAR(n)`                    | `CHAR(n)`                           |
| ------------------ | ------------------------------- | ----------------------------------- |
| দৈর্ঘ্য            | ভ্যারিয়েবল (পরিবর্তনশীল)        | নির্দিষ্ট (Fixed)                   |
| স্টোরেজ            | যতটুকু দরকার ততটুকু ব্যবহার করে | সব সময় পূর্ণ `n` চরিত্র ব্যবহার করে |
| স্পেস ফিল করে কিনা | না                              | হ্যাঁ (বাকি জায়গা স্পেস দিয়ে পূরণ)  |
| পারফরম্যান্স       | কিছুটা কম                       | তুলনামূলক বেশি                      |

---

###  সংক্ষিপ্ত উদাহরণ:

```sql
-- VARCHAR:
CREATE TABLE users (
    username VARCHAR(10)
);

-- CHAR:
CREATE TABLE users (
    username CHAR(10)
);
```

* যদি `username` এ "Ali" ইনপুট দেন:

  * `VARCHAR` → "Ali" (3 characters)
  * `CHAR` → "Ali       " (3 + 7 spaces)

---

**সারাংশ:**

✅ ছোট বা পরিবর্তনশীল ডেটা → `VARCHAR`

✅ নির্দিষ্ট দৈর্ঘ্যের ডেটা → `CHAR`

<br>

# 5. Explain the purpose of the `WHERE` clause in a `SELECT` statement.


**`WHERE` clause** ব্যবহার করা হয় **ডেটাবেইস টেবিল থেকে নির্দিষ্ট শর্ত অনুযায়ী ডেটা ফিল্টার** করার জন্য। অর্থাৎ, আপনি যখন `SELECT` ব্যবহার করেন, তখন `WHERE` এর মাধ্যমে আপনি বলতে পারেন— **"আমি শুধু সেই রেকর্ডগুলো দেখতে চাই যেগুলো এই শর্ত পূরণ করে"**।

---

###  সাধারণ রূপ:

```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```

---

###  উদাহরণ:

ধরা যাক আমাদের একটি `students` টেবিল আছে:

```sql
SELECT * FROM students
WHERE age > 18;
```

এই কুয়েরি শুধুমাত্র **১৮ বছরের বেশি বয়সের ছাত্রদের** তথ্য দেখাবে।

---

###  আরও কিছু উদাহরণ:

1️⃣ **নির্দিষ্ট দেশের ছাত্র দেখানো:**

```sql
SELECT name FROM students
WHERE country = 'Bangladesh';
```

2️⃣ **ইমেইল যাদের NULL নয়:**

```sql
SELECT email FROM students
WHERE email IS NOT NULL;
```

3️⃣ **শুধু "A+" গ্রেডপ্রাপ্তরা:**

```sql
SELECT * FROM students
WHERE grade = 'A+';
```

---

### সংক্ষেপে বললে:

| বিষয়              | ব্যাখ্যা                               |
| ----------------- | -------------------------------------- |
| কী করে?           | শর্ত অনুযায়ী নির্দিষ্ট রেকর্ড বেছে নেয় |
| কোথায় ব্যবহার হয়? | `SELECT`, `UPDATE`, `DELETE` ইত্যাদিতে |
| কাজ করে কিভাবে?   | শর্ত মিললে সেই রেকর্ডই ফলাফল দেয়       |

---

**উপসংহার:**
`WHERE` clause হলো ডেটা খোঁজার সবচেয়ে গুরুত্বপূর্ণ অংশ—যার মাধ্যমে আপনি টেবিল থেকে **নির্দিষ্ট তথ্য আলাদা করে বের করতে** পারেন।

