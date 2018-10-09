/**
* This is an abstract class that each recurrence rule should specialize.
*/
component accessors="true" {

    /** Valid values are yearly, monthly, weekly, daily, hourly, minutely, and secondly */
    property name="frequency" type="string";

    /** The count value is an optional way to impose a recurrence bound */
    property name="count" type="numeric";

    /** An optional datetime bound like 20181231T233000Z */
    property name="until" type="string";
    /**
    * Concrete implementations should call the super constructor, though this doesn't yet do anything fancy.
    */
    public RecurrenceRule function init() {
        variables.frequency = "";
        variables.count = 0;
        variables.until = "";

        return this;
    }

    /**
    * Each subclass should override this method to create a valid RRULE
    */
    public string function generateRRule() {
        throw(type="Exception", message="This method must be implemented by a subclass.");
    }

    /**
    * Adds the count and until bounding attributes when appropriate
    * @rrule A valid RRULE string to be enhanced
    */
    private string function appendBounders(required string rrule) {
        // One or the other
        if (variables.count > 0) {
            return arguments.rrule & ";COUNT=#variables.count#";
        }
        if (len(variables.until)) {
            return arguments.rrule & ";UNTIL=#variables.until#";
        }
        // Pass it through without modification, which is fine
        return arguments.rrule;
    }

}