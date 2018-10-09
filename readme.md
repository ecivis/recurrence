[![Master Branch Build Status](https://img.shields.io/travis/ecivis/recurrence/master.svg?style=flat-square&label=master)](https://travis-ci.org/ecivis/recurrence)

## Description
This project is a ColdBox Module to assist in processing recurring events. It is useful to create ICS RRULE statements or to iterate over a series of datetimes for a given recurrence rule.

The [lib-recur](https://github.com/dmfs/lib-recur) and [rfc5545-datetime](https://github.com/dmfs/rfc5545-datetime) Java libraries are used in this project, obtained from MvnRepository ([lib-recur-0.10.3](https://mvnrepository.com/artifact/org.dmfs/lib-recur/0.10.3) and [rfc5545-datetime-0.2.1](https://mvnrepository.com/artifact/org.dmfs/rfc5545-datetime/0.2.1)).


## Requirements

* Lucee 5+
* Java 8+


## Installation
Install with CommandBox, like so:
```sh
package install id=recurrence production=true
```
The project will be installed to `./modules/recurrence` unless overridden using the `directory` parameter.

If you're not yet running Lucee 5.2, you'll need to drop this into your `Application.cfc`:
```cfc
this.javaSettings = {
    loadPaths: [expandPath("/modules/recurrence/lib/")],
    loadCFMLClassPath: false
};
```
If you are already on Lucee 5.2 or later, the JAR files will be located automatically.


## Usage
When your ColdBox application starts, the module will be configured and available for injection as `Recurrence@recurrence`.

Here's a use case: Say you'd like a collection of the next 12 recurrences of an event starting a month ago and repeating every other Tuesday:
```cfc
var start = "20180904";
var count = 12;
var recur = getInstance("Recurrence@recurrence");
var recurrenceRule = recur.createRecurrenceRule("SimpleWeeklyRule");
recurrenceRule.setInterval(2);
recurrenceRule.setOnDay("TU");
var recurrenceIterator = recur.createRecurrenceIterator(rrule=recurrenceRule.generateRRule(), start=start, count=count);
var recurrenceSet = [];
while (recurrenceIterator.hasNext()) {
    recurrenceSet.append(recurrenceIterator.next());
}
writeDump(var=recurrenceSet, abort=true);
```
The result is an array with 12 elements, each a string representing a recurrence.


## Documentation
To generate API documentation, ensure that the [DocBox Commands](https://github.com/Ortus-Solutions/commandbox-docbox) system package (v1.3 or later) is available in your [CommandBox](https://www.ortussolutions.com/products/commandbox) installation. Then run the documentation generation script.
```sh
package install id="commandbox-docbox@>=1.3.2" system=true
package run-script generateDocs
```
The generated documentation is written to `./apidocs/index.html`


## Tests
To run the test specifications (if the package was installed in non-production mode), first start the [CommandBox](https://www.ortussolutions.com/products/commandbox) embedded server (`server start`), then wait a moment for the server to become available and execute `testbox run`.


## To-Do List

* `Recurrence.getNextRecurrence()` to get the soonest next recurrence after today.
* Implement more advanced rules, for example "Tuesdays and Thursdays of every second week."


## License
This project is licensed under the terms of the MIT license.
