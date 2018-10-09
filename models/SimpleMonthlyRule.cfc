/**
* Models the simplest monthly recurrence on a single day of the calendar page. It doesn't support multiple days during the month or logic like the 3rd Monday.
*/
component accessors="true" extends="RecurrenceRule" {

    /** Number of months between recurrence */
    property name="interval" type="numeric";

    /** The recurrence is on this day of the month, or no value when the recurrence is the last day of the month */
    property name="on" type="numeric";

    /** Flag to indicate recurrence is on the last day of the month */
    property name="onLast" type="boolean";

    /**
    * The constructor sets some default values
    */
    public SimpleMonthlyRule function init() {
        super.init();

        variables.frequency = "monthly";
        variables.on = 0;
        variables.onLast = false;

        return this;
    }

    /**
    * This adds a wee bit of validation to the default setter
    * @on The numeric day of the month
    */
    public void function setOn(required numeric on) {
        // There are very few months with 32 days
        if (arguments.on < 1 || arguments.on > 31) {
            throw(type="InvalidValueException", message="The specified numeric day of month is not valid.");
        }
        variables.on = arguments.on;
    }

    /**
    * Generates the appropriate RRULE to represent the monthly recurrence.
    */
    public string function generateRRule() {
        // There is no default day of the month. If it's not defined, that's en error.
        if (variables.on == 0 && !variables.onLast) {
            throw(type="InvalidRecurrenceRuleException", message="A RRULE cannot be generated until the required properties are defined.");
        }

        var rrule = "";

        if (variables.onLast) {
            rrule = "FREQ=MONTHLY;INTERVAL=#variables.interval#;BYMONTHDAY=-1";
        } else {
            rrule = "FREQ=MONTHLY;INTERVAL=#variables.interval#;BYMONTHDAY=#variables.on#";
        }

        return appendBounders(rrule);
    }

}