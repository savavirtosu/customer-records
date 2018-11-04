# Customer Records

## Table of Contents

* [Problem Definition](#Problem-Definition)
* [Solution Description](#Solution-Description)
* [Solution Results](#Solution-Results)
* [Development & Shipping Instruction](#Development-&-Shipping-Instruction)

## Problem Definition

We have some customer records in a text file (customers.txt) -- one customer per line, JSON lines formatted. We want to invite any customer within 100km of our Dublin office for some food and drinks on us. Write a program that will read the full list of customers and output the names and user ids of matching customers (within 100km), sorted by User ID (ascending).

You can use the first formula from [this Wikipedia article](https://en.wikipedia.org/wiki/Great-circle_distance) to calculate distance. Don't forget, you'll need to convert degrees to radians.
The GPS coordinates for our Dublin office are 53.339428, -6.257664.
You can find the Customer list [here](https://s3.amazonaws.com/intercom-take-home-test/customers.txt).
We're looking for you to produce working code, with enough room to demonstrate how to structure components in a small program.

* Poor answers will be in the form of one big function. It’s impossible to test anything smaller than the entire operation of the program, including reading from the input file. Errors are caught and ignored.

* Good answers are well composed. Calculating distances and reading from a file are separate concerns. Classes or functions have clearly defined responsibilities. Test cases cover likely problems with input data.

* It’s an excellent answer if we've learned something from reading the code.

We recommend you use whatever language you feel strongest in. It doesn't have to be one we use!

⭑ Please submit code as if you intended to ship it to production. The details matter. Tests are expected, as is well written, simple idiomatic code. Please include the output of your program with your code.

## Solution Description

The following solution is implemented in `ruby` and is shipped using `Docker`. It relies mostly on ruby standard library, and has only 2 dependencies, managed by [bundler](https://bundler.io/) both specified in Gemfile. The dependencies are the following:

* [dotenv](https://github.com/bkeepers/dotenv) - Used to store app configuration separated from the code.
* [rspec](https://github.com/rspec/rspec) - Used for unit testing.

The app is developed using [Multitier architecture](https://en.wikipedia.org/wiki/Multitier_architecture) and tries to follow SOLID principles. 

The current implementation use `in memory` storage, but it could be easily extended to support a DB storage. It loads customers data from a `txt` file, but also, it could be extended (by adding a new fetcher) to load data from an URL. It presents data in a dummy way, by outputting it to `stdout`, but also, it could be extended with a new presenter if you would like to send results through email, or render an HTML file. Calculation of the distance between two geo-coordinates is separated from the business logic and extracted in the `lib` such what it could be separated in the future in a standalone library used between projects. All tests are located in `specs` folder and have the same structure as the project.

## Solution Results

The results of execution are the following:

```shell
Customers within 100km range of Dublin:
4: Ian Kehoe
5: Nora Dempsey
6: Theresa Enright
8: Eoin Ahearn
11: Richard Finnegan
12: Christina McArdle
13: Olive Ahearn
15: Michael Ahearn
17: Patricia Cahill
23: Eoin Gallagher
24: Rose Enright
26: Stephen McArdle
29: Oliver Ahearn
30: Nick Enright
31: Alan Behan
39: Lisa Ahearn
Total in range = 16
```

## Development & Shipping Instruction

This app is shipped using `Docker`. In order to build and run it, you must first install it first.

To build Docker image run: `docker build -t=customer-records .`

To run it: `docker run -it customer-records bundle exec ruby main.rb`

To run tests: `docker run -it customer-records bundle exec rspec`