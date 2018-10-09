## Description
This project is a ColdBox Module to assist in processing recurring events. It is useful to create ICS RRULE statements or to iterate over a series of datetimes for a given recurrence rule.

The [lib-recur](https://github.com/dmfs/lib-recur) and [rfc5545-datetime](https://github.com/dmfs/rfc5545-datetime) Java libraries are used. The JAR files were obtained from https://mvnrepository.com/artifact/org.dmfs/lib-recur/0.10.3 and https://mvnrepository.com/artifact/org.dmfs/rfc5545-datetime/0.2.1


## Requirements

* Lucee 5+
* Java 8+


## Installation
Install with CommandBox, like so:
```
package install id=recurrence production=true
```
The project will be installed to `./modules/recurrence` unless overridden using the `directory` parameter.

If you're not yet running Lucee 5.2, you'll need to drop this into your `Application.cfc`:
```
    this.javaSettings = {
        loadPaths: [expandPath("/modules/recurrence/lib/")],
        loadCFMLClassPath: false
    };
```
If you are already on Lucee 5.2 or later, the JAR files will be located automatically.


## Usage
When your ColdBox application starts, the module will be configured and available for injection as `Recurrence@recurrence`.

Here's a use case: Say you'd like a collection of the next 12 recurrences of an event starting a month ago and repeating every other Tuesday:
```
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


## Tests
To run the test specifications, first start the CommandBox embedded server (`server start`), then execute `testbox run`.


## License
This project is licensed under the terms of the MIT license.