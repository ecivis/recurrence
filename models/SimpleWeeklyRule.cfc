/**
* Models the simplest weekly recurrence on a single day of the week. It doesn't support repeating on multiple days each week.
*/
component accessors="true" extends="RecurrenceRule" {

    /** Number of weeks between recurrence */
    property name="interval" type="numeric";

    /** The recurrence is on this day of the week, where 1 is Monday, 2 is Tuesday, etc. */
    property name="on" type="numeric";

    /**
    * The constructor sets some default values
    */
    public SimpleWeeklyRule function init() {
        super.init();

        variables.frequency = "weekly";
        variables.on = 0;
        variables.daysOfWeek = ["MO", "TU", "WE", "TH", "FR", "SA", "SU"];

        return this;
    }

    /**
    * Set the day of the week for recurrence, which is useful when it's stored as SMALLINT in the database
    * @on The numeric day of the week
    */
    public void function setOn(required numeric on) {
        // Pretty sure there will only be seven days in most future weeks, but let's not assume. Heh.
        if (arguments.on < 1 || arguments.on > arrayLen(variables.daysOfWeek)) {
            throw(type="InvalidValueException", message="The specified numeric day of week is not valid.");
        }
        variables.on = arguments.on;
    }

    /**
    * This is a convenience method so the caller doesn't need to know which number Monday is
    * @onDay An identifier like MO or TU
    */
    public void function setOnDay(required string onDay) {
        var dow = arrayFind(variables.daysOfWeek, arguments.onDay);

        if (dow == 0) {
            throw(type="InvalidValueException", message="The specified day of week abbreviation is not valid.");
        }
        variables.on = dow;
    }

    /**
    * Generates the appropriate RRULE to represent the weekly recurrence.
    */
    public string function generateRRule() {
        // There is no default day of the week. If it's not defined, that's en error.
        if (variables.on == 0) {
            throw(type="InvalidRecurrenceRuleException", message="A RRULE cannot be generated until the required properties are defined.");
        }

        var rrule = "FREQ=WEEKLY;INTERVAL=#variables.interval#;BYDAY=#variables.daysOfWeek[variables.on]#";
        return appendBounders(rrule);
    }

}